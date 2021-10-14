import 'package:flutter/material.dart';
import 'package:scoresheet/apis/ExportApi.dart';
import 'package:scoresheet/companants/AssignmentHeader.dart';
import 'package:scoresheet/companants/TeachCourseHeader.dart';
import 'package:scoresheet/companants/TeachStudentHeader.dart';
import 'package:scoresheet/models/TeachCourse.dart';


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
          Icons.print,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
