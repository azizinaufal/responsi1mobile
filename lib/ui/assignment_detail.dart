import 'package:flutter/material.dart';
import 'package:responsi1/bloc/assignment_bloc.dart';
import 'package:responsi1/model/assignment.dart';
import 'package:responsi1/ui/assignment_form.dart';
import 'package:responsi1/ui/assignment_page.dart';

class AssignmentDetail extends StatefulWidget {
  Assignment? assignment;
  AssignmentDetail({Key? key, this.assignment}) : super(key: key);

  @override
  _AssignmentDetailState createState() => _AssignmentDetailState();
}

class _AssignmentDetailState extends State<AssignmentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Assignment'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Title : ${widget.assignment!.judulTugas}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Description : ${widget.assignment!.deskripsiTugas}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Deadline : ${widget.assignment!.deadlineTugas}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolEditDelete()
          ],
        ),
      ),
    );
  }

  Widget _tombolEditDelete() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssignmentForm(
                            assignment: widget.assignment!,
                          )));
            }),
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            AssignmentBloc.deleteAssignment(id: widget.assignment!.id);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AssignmentPage()));
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
