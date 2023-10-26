import 'package:flutter/material.dart';
import 'package:responsi1/bloc/assignment_bloc.dart';
import 'package:responsi1/model/assignment.dart';
import 'package:responsi1/ui/assignment_form.dart';
import 'package:responsi1/ui/assignment_detail.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key}) : super(key: key);

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Tugas'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AssignmentForm()));
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Assignment>>(
        future: AssignmentBloc.getAssignment(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          }
          return snapshot.hasData
              ? ListAssignment(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemAssignment extends StatelessWidget {
  final Assignment assignment;

  const ItemAssignment({Key? key, required this.assignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentDetail(
              assignment: assignment,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(assignment.judulTugas!),
          subtitle: Text(assignment.deskripsiTugas!),
        ),
      ),
    );
  }
}

class ListAssignment extends StatelessWidget {
  final List<Assignment>? list;

  const ListAssignment({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemAssignment(
          assignment: list![i],
        );
      },
    );
  }
}
