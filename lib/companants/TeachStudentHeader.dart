import 'package:flutter/material.dart';
import 'package:scoresheet/apis/TeachStudentApi.dart';
import 'package:scoresheet/models/TeachCourse.dart';
import 'package:scoresheet/models/TeachStudent.dart';
import 'package:scoresheet/pages/TeachStudentPage.dart';

class TeachStudentHeader extends StatefulWidget {
  TeachCourse teachCourse;
  TeachStudentHeader({required this.teachCourse});
  @override
  _TeachStudentHeader createState() =>
      _TeachStudentHeader(teachCourse: teachCourse);
}

class _TeachStudentHeader extends State<TeachStudentHeader> {
  TeachCourse teachCourse;
  _TeachStudentHeader({required this.teachCourse});
  List<TeachStudent> _teachStudents = [];
  @override
  void initState() {
    super.initState();
    getTeachStudents();
  }

  void getTeachStudents() async {
    final teachStudents = await TeachStudentApi.getTeachStudents(this.teachCourse.teachCourseId);
    setState(() {
      _teachStudents = teachStudents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.perm_identity,
                      size: 40.0,
                    ),
                    Text('Student totals')
                  ],
                ),
                Text(_teachStudents.length.toString())
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TeachStudentPage(teachCourse: teachCourse,getTeachStudents: getTeachStudents,))
              );
            },
          ),
        )
    );
  }
}