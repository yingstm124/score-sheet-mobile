import 'package:flutter/material.dart';
import 'package:scoresheet/models/TeachCourse.dart';

class TeachCourseHeader extends StatelessWidget {
  TeachCourse teachCourse;
  TeachCourseHeader({required this.teachCourse});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            teachCourse.courseName,
            style: TextStyle(fontSize: 20.0),
          ),
          Text(teachCourse.courseId.toString()),
        ],
      ),
    );
  }
}
