
import 'package:flutter/material.dart';
import 'package:scoresheet/apis/AssignmentApi.dart';
import 'package:scoresheet/models/Counter.dart';
import 'package:scoresheet/models/TeachCourse.dart';
import 'package:scoresheet/pages/AssignmentPage.dart';

class AssignmentHeader extends StatefulWidget {
  TeachCourse teachCourse;
  AssignmentHeader({required this.teachCourse});

  @override
  _AssignmentHeader createState() =>
      _AssignmentHeader(teachCourse: teachCourse);
}

class _AssignmentHeader extends State<AssignmentHeader> {
  TeachCourse teachCourse;
  _AssignmentHeader({required this.teachCourse});
  Counter _totalAssignments = new Counter(count: 0);

  @override
  void initState() {
    super.initState();
    getTotalAssignments();
  }

  void getTotalAssignments() async {
    final assignments = await AssignmentApi.getTotalAssignments(this.teachCourse.teachCourseId);
    setState(() {
      _totalAssignments = assignments;
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
                      Icons.school,
                      size: 40.0,
                    ),
                    Text('Assignment totals')
                  ],
                ),
                Text(_totalAssignments.count.toString())
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AssignmentPage(teachCourse: teachCourse)
                  ));
            },
          ),
        )
    );
  }
}