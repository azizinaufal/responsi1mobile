import 'package:flutter/material.dart';
import 'package:responsi1/bloc/assignment_bloc.dart';
import 'package:responsi1/model/assignment.dart';
import 'package:responsi1/ui/assignment_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

class AssignmentForm extends StatefulWidget {
  Assignment? assignment;
  AssignmentForm({Key? key, this.assignment}) : super(key: key);
  @override
  _AssignmentFormState createState() => _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH Tugas";
  String tombolSubmit = "SIMPAN";

  final _judulTugasTextboxController = TextEditingController();
  final _deskripsiTugasTextboxController = TextEditingController();
  final _deadlineTugasTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.assignment != null) {
      setState(() {
        judul = "UBAH Tugas ";
        tombolSubmit = "UBAH";
        _judulTugasTextboxController.text = widget.assignment!.judulTugas!;
        _deskripsiTugasTextboxController.text =
            widget.assignment!.deskripsiTugas!;
        _deadlineTugasTextboxController.text =
            widget.assignment!.deadlineTugas.toString();
      });
    } else {
      judul = "TAMBAH Tugas ";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _judulTugasTextField(),
                _deskripsiTugasTextField(),
                _deadlineTugasTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _judulTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Tugas"),
      keyboardType: TextInputType.text,
      controller: _judulTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Tugas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deskripsiTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deskripsi"),
      keyboardType: TextInputType.number,
      controller: _deskripsiTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deskripsi harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deadlineTugasTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deadline"),
      keyboardType: TextInputType.number,
      controller: _deadlineTugasTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deadline tugas kapan coba ";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.assignment != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Assignment createAssignment = Assignment(id: null);
    createAssignment.judulTugas = _judulTugasTextboxController.text;
    createAssignment.deskripsiTugas = _deskripsiTugasTextboxController.text;
    createAssignment.deadlineTugas = _deadlineTugasTextboxController.text;
    AssignmentBloc.addAssignment(assignment: createAssignment).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AssignmentPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Assignment updateAssignment = Assignment(id: widget.assignment!.id);
    updateAssignment.judulTugas = _judulTugasTextboxController.text;
    updateAssignment.deskripsiTugas = _deskripsiTugasTextboxController.text;
    updateAssignment.deadlineTugas = _deadlineTugasTextboxController.text;
    AssignmentBloc.updateAssignment(assignment: updateAssignment).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AssignmentPage()));
    }, onError: (error) {
      print('error = $error');
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan cobalagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
