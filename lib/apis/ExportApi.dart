import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled/helpers/BaseApi.dart';
import 'package:untitled/models/ExportScoreInfo.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:untitled/models/TeachCourse.dart';

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

    sheet.getRangeByName('A1').setText("รหัสนักศึกษา");
    sheet.getRangeByName('B1').setText("ชื่อนักศึกษา");
    sheet.getRangeByName('C1').setText("ชื่อการสอบย่อย");
    sheet.getRangeByName('D1').setText("คะแนนที่ได้");
    sheet.getRangeByName('E1').setText("คะแนนเต็ม");

    datas.asMap()
        .forEach((index, value) {
      sheet.getRangeByName('A${index+2}').setText(value.studentId.toString());
      sheet.getRangeByName('B${index+2}').setText(value.fullName);
      sheet.getRangeByName('C${index+2}').setText(value.assignmentName);
      sheet.getRangeByName('D${index+2}').setText(value.score == null ? "0": value.score.toString());
      sheet.getRangeByName('E${index+2}').setText(value.fullScore.toString());
    });

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final directory = await getExternalStorageDirectory();
    final path = directory!.path;
    File file = File('$path/Report.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/Report.xlsx');
  }
}