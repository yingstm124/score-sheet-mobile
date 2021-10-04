import 'package:flutter/material.dart';
import 'package:scoresheet/apis/AssignmentApi.dart';
import 'package:scoresheet/models/Assignment.dart';

class AssignmentEditForm extends StatefulWidget {

  Assignment assignment;
  Function getAssignments;
  AssignmentEditForm({
    required this.assignment,
    required this.getAssignments,
  });

  @override
  _AssignmentEditForm createState() => _AssignmentEditForm(assignment: assignment, getAssignments: getAssignments );
}

class _AssignmentEditForm extends State<AssignmentEditForm> {
  Assignment assignment;
  Function getAssignments;
  _AssignmentEditForm({
    required this.assignment,
    required this.getAssignments,
  });

  final _formKey = GlobalKey<FormState>();

  String newAssignmentName = "";

  @override
  void initState() {
    setState(() {
      newAssignmentName = assignment.assignmentName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText:  "Enter Assignment name"),
              initialValue: "${assignment.assignmentName}",
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter assignment name';
                }
                return null;
              },
              onChanged: (String value) async {
                setState(() {
                  newAssignmentName = value;
                });
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
                        final _editAssignmentSuccess = await AssignmentApi.editAssignment(assignment.assignmentId, newAssignmentName);
                        if(_editAssignmentSuccess){
                          getAssignments();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                          'Submit'
                      )
                  ),
                )
              ],
            )
          ],
        ));
  }
}