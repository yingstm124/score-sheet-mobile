import 'package:flutter/material.dart';
import 'package:untitled/apis/ExportApi.dart';
import 'package:untitled/companants/AssignmentHeader.dart';
import 'package:untitled/companants/TeachCourseHeader.dart';
import 'package:untitled/companants/TeachStudentHeader.dart';
import 'package:untitled/models/TeachCourse.dart';


class TeachCoursePage extends StatelessWidget {
  TeachCourse teachCourse;
  TeachCoursePage({required this.teachCourse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester ${teachCourse.term}/${teachCourse.year}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TeachCourseHeader(teachCourse: teachCourse),
                  TeachStudentHeader(teachCourse: teachCourse),
                  AssignmentHeader(teachCourse: teachCourse)
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final results = await ExportApi.getExportInfo(teachCourse.teachCourseId);
          await ExportApi.createExcel(results, teachCourse);
        },
        child: Icon(
          Icons.file_download,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
