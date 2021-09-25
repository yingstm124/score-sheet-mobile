import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:untitled/helpers/BaseApi.dart';
import 'package:untitled/models/AddStudent.dart';
import 'package:untitled/models/Counter.dart';
import 'package:untitled/models/TeachStudent.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeachStudentApi {
  static final String _baseUrl = BaseApi.getBaseAPI();

  static Future<List<TeachStudent>> getTeachStudents(int _teachCourseId) async {
    String url = _baseUrl + '/teachStudents?teachCourseId=${_teachCourseId}';
    EasyLoading.show(status: 'loading..');
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final List<dynamic> result = jsonDecode(res.body);
      List<TeachStudent> lists = result.map((e) => TeachStudent.fromJson(e)).toList();
      EasyLoading.dismiss();
      return lists;
    } else {
      EasyLoading.showError('Failed with Error');
      throw Exception("Failed !");
    }
  }

  static Future<Counter> getTotalTeachStudents(int _teachCourseId) async{
    String url = _baseUrl + '/countTeachStudents?teachCourseId=${_teachCourseId.toInt()}';
    EasyLoading.show(status: 'loading..');
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final dynamic result = jsonDecode(res.body);
      Counter totalStudent = Counter.fromJson(result);
      EasyLoading.dismiss();
      return totalStudent;
    } else {
      EasyLoading.showError('Failed with Error');
      throw Exception("Failed !");
    }
  }

  static Future<List<AddStudent>> addTeachStudents(int _teachCourseId, List<TeachStudent> _data) async {
    String url = _baseUrl + '/addTeachStudents?teachCourseId=${_teachCourseId.toString()}';
    final jsonData = _data.map((e) => jsonEncode(<String,String>{
      "StudentId": e.studentId.toString(),
      "TeachStudentId": 0.toString(),
      "SecNo": e.secNo.toString(),
      "FirstName": e.firstName,
      "LastName": e.lastName,
      "NickName": e.nickName,
      "IsRegister": true.toString()
    })).toList();
    EasyLoading.show(status: 'loading..');
    final res = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode(jsonData)
    );

    if (res.statusCode == 200) {
      final List<dynamic> result = jsonDecode(res.body);
      List<AddStudent> lists = result.map((e) => AddStudent.fromJson(e)).toList();
      EasyLoading.dismiss();
      return lists;
    } else {
      EasyLoading.showError('Failed with Error');
      throw Exception("Failed !");
    }

    EasyLoading.dismiss();
    throw Exception("Failed !");
  }

  static Future<bool> deleteTeachStudents(int _teachStudentId) async{
    String url = _baseUrl + '/deleteTeachStudent?teachStudentId=${_teachStudentId.toInt()}';
    EasyLoading.show(status: 'loading..');
    final res = await http.post(Uri.parse(url));

    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.showError('Failed with Error');
      EasyLoading.dismiss();
      throw Exception("Failed !");
    }
  }

}