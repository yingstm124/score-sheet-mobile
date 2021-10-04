import 'package:flutter/material.dart';
import 'package:scoresheet/apis/TeachCourseApi.dart';
import 'package:scoresheet/models/TeachCourse.dart';
import 'package:scoresheet/pages/TeachCoursePage.dart';

class TeachCourses extends StatefulWidget {
  @override
  _TeachCourses createState() => _TeachCourses();
}

class _TeachCourses extends State<TeachCourses> {
  List<TeachCourse> _teachCourses = [];

  @override
  void initState() {
    super.initState();
    getTeachCourses();
  }

  void getTeachCourses() async {
    final teachCourses = await TeachCourseApi.getTeachCourses();
    setState(() {
      _teachCourses = teachCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _teachCourses.length,
        itemBuilder: (context, index) {
          final teachCourse = _teachCourses[index];
          return Card(
              child: InkWell(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          '${teachCourse.courseName}  (${teachCourse.courseId.toString()})'),
                      subtitle: Text('Semester ${teachCourse.term}/${teachCourse.year}'),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TeachCoursePage(teachCourse: teachCourse)));
                },
              ));
        });
  }
}