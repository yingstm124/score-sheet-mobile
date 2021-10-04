import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:scoresheet/apis/AssignmentApi.dart';
import 'package:scoresheet/models/Assignment.dart';
import 'package:scoresheet/models/TeachCourse.dart';

class AssignmentAddForm extends StatefulWidget {
  Function getAssignments;
  TeachCourse teachCourse;
  AssignmentAddForm({
    required this.teachCourse,
    required this.getAssignments});
  @override
  _AssignmentAddForm createState() => _AssignmentAddForm(teachCourse: teachCourse, getAssignments: getAssignments);
}

class _AssignmentAddForm extends State<AssignmentAddForm> {
  Function getAssignments;
  TeachCourse teachCourse;
  _AssignmentAddForm({ required this.teachCourse, required this.getAssignments});

  final _formKey = GlobalKey<FormState>();
  final _assignmentName = TextEditingController();
  final _fullscore = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _assignmentName,
              decoration: InputDecoration(labelText:  "Enter Assignment name"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter assignment name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _fullscore,
              decoration: InputDecoration(labelText: "Enter Full Score"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter score';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          'Cancel'
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: ElevatedButton(
                      onPressed: () async{

                        if(_formKey.currentState!.validate()){
                          final assignment = new Assignment(assignmentId: 0, assignmentName: _assignmentName.text, fullScore: int.parse(_fullscore.text), teachCourseId: teachCourse.courseId);
                          final _addAssignmentSuccess = await AssignmentApi.addAssignment(teachCourse.teachCourseId, assignment);

                          if(_addAssignmentSuccess){
                            getAssignments();

                            Navigator.of(context).pop();
                          }
                        }

                      },
                      child: Text('Submit')
                  ),
                )
              ],
            )
          ],
        )
    );
  }
}