import 'package:scoresheet/helpers/BaseApi.dart';
import 'package:scoresheet/models/StudentScoreResponse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StudentScoreApi {

  static final String _baseUrl = BaseApi.getBaseAPI();

  static Future<StudentScoreResponse> saveScore(
      List<dynamic> _scores,
      String _studentId,
      int _assignmentId,
      int _teachCourseId,
      int _teachStudentId) async {
    String url = _baseUrl + '/saveScore';
    print(url);
    final headers = {
      "Content-Type": "application/json"
    };
    final jsonData = jsonEncode(<String,dynamic>{
      "AssignmentId": _assignmentId.toString(),
      "Scores": _scores,
      "StudentId": _studentId.toString(),
      "AssignmentId": _assignmentId.toString(),
      "TeachCourseId": _teachCourseId.toString(),
      "TeachStudentId": _teachStudentId.toString()
    });
    EasyLoading.show(status: 'loading..');
    final res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonData
    );

    if(res.statusCode == 200){
      EasyLoading.dismiss();
      final dynamic result = jsonDecode(res.body);
      StudentScoreResponse response = StudentScoreResponse.fromJson(result);
      if(response.message == "Not Found Student"){
        EasyLoading.showError(response.message);
        EasyLoading.dismiss();
      }
      return response;
    }
    else {
      EasyLoading.showError('Can not Detect');
      EasyLoading.dismiss();
      throw Exception("Failed !");
    }

  }
}