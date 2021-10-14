import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoresheet/helpers/BaseApi.dart';
import 'package:scoresheet/models/ExportScoreInfo.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:scoresheet/models/TeachCourse.dart';
import "package:collection/collection.dart";

class ExportApi {
  static final String _baseUrl = BaseApi.getBaseAPI();

  static Future<List<ExportScoreInfo>> getExportInfo(int _teachCourseId) async {
    String url = _baseUrl + '/exportScoreInfo?teachCourseId=${_teachCourseId.toInt()}';
    EasyLoading.show(status: 'loading..');
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final List<dynamic> result = jsonDecode(res.body);
      List<ExportScoreInfo> lists =
      result.map((e) => ExportScoreInfo.fromJson(e)).toList();
      EasyLoading.dismiss();
      return lists;
    } else {
      EasyLoading.showError('Failed with Error');
      EasyLoading.dismiss();
      throw Exception("Failed !");
    }
  }

  static Future<void> createExcel(List<ExportScoreInfo> datas, TeachCourse teachCourse) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    List<String> alphas = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
    List<String> assignmentHeaders = [];
    sheet.getRangeByName('A1').setText("รหัสนักศึกษา");
    sheet.getRangeByName('B1').setText("ชื่อนักศึกษา");

    datas.forEach((element) {
      if(!assignmentHeaders.contains(element.assignmentName)){
        assignmentHeaders.add(element.assignmentName);
      }
    });
    int indx = 0;
    assignmentHeaders.forEach((element) {
      sheet.getRangeByName('${alphas[indx+2]}1').setText(element);
      indx +=1;
    });
    sheet.getRangeByName('${alphas[indx+2]}1').setText("คะแนนที่ได้");
    sheet.getRangeByName('${alphas[indx+3]}1').setText("คะแนนเต็ม");

    // map data
    Map<String, List<dynamic>> reports = Map();
    datas.forEach((element) {
      List<dynamic> temp = [];
      if(!reports.containsKey(element.studentId)){
        temp.add(element.studentId);
        temp.add(element.fullName);
        int sumScore = 0;
        assignmentHeaders.forEach((assignmentName) {
          datas.forEach((ele) {
            if(ele.studentId == element.studentId && ele.assignmentName == assignmentName){
              temp.add(ele.score == null ? 0 : ele.score);
              if(ele.score != null){
                sumScore += ele.score!;
              }
            }
          });
        });
        temp.add(sumScore);
        temp.add(element.fullScore);
        reports[element.studentId.toString()] = temp;
      }
    });
    reports.forEach((key, value) {
      print('${key} : ${value}');
    });

    int indxReport = 0;
    reports.forEach((key, value) {
      int j = 0;
      value.forEach((element) {
        sheet.getRangeByName('${alphas[j]}${indxReport+2}').setText(element.toString());
        j += 1;
      });
      indxReport += 1;
    });

    // datas.asMap()
    //     .forEach((index, value) {
    //   sheet.getRangeByName('A${index+2}').setText(value.studentId.toString());
    //   sheet.getRangeByName('B${index+2}').setText(value.fullName);
    //   sheet.getRangeByName('C${index+2}').setText(value.assignmentName);
    //   sheet.getRangeByName('D${indx+2}').setText(value.score == null ? "0": value.score.toString());
    //   sheet.getRangeByName('E${indx+3}').setText(value.fullScore.toString());
    // });

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getExternalStorageDirectory();
    final path = directory!.path;
    File file = File('$path/${teachCourse.courseId}_${teachCourse.term}_${teachCourse.year}.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/${teachCourse.courseId}_${teachCourse.term}_${teachCourse.year}.xlsx');
  }
}