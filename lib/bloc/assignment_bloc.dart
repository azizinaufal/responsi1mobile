import 'dart:convert';
import 'package:responsi1/helpers/api.dart';
import 'package:responsi1/helpers/api_url.dart';
import 'package:responsi1/model/assignment.dart';

class AssignmentBloc {
  static Future<List<Assignment>> getAssignment() async {
    String apiUrl = ApiUrl.listAssignment;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listAssignment = (jsonObj as Map<String, dynamic>)['result'];
    List<Assignment> assignments = [];
    for (int i = 0; i < listAssignment.length; i++) {
      assignments.add(Assignment.fromJson(listAssignment[i]));
    }
    return assignments;
  }

  static Future addAssignment({Assignment? assignment}) async {
    String apiUrl = ApiUrl.createAssignment;

    var body = {
      "title": assignment!.judulTugas,
      "description": assignment.deskripsiTugas,
      "deadline": assignment.deadlineTugas,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateAssignment({required Assignment assignment}) async {
    String apiUrl = ApiUrl.updateAssignment(assignment.id!);

    var body = {
      "title": assignment.judulTugas,
      "description": assignment.deskripsiTugas,
      "deadline": assignment.deadlineTugas
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);

    if (jsonObj['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteAssignment({int? id}) async {
    String apiUrl = ApiUrl.deleteAssignment(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['result'];
  }
}
