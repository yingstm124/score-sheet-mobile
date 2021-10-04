import 'package:flutter/material.dart';
import 'package:scoresheet/apis/AssignmentApi.dart';
import 'package:scoresheet/companants/AssignmentAddForm.dart';
import 'package:scoresheet/companants/AssignmentEditForm.dart';
import 'package:scoresheet/companants/TeachCourseHeader.dart';
import 'package:scoresheet/models/Assignment.dart';
import 'package:scoresheet/models/TeachCourse.dart';
import 'StudentAssignmentPage.dart';

class AssignmentPage extends StatefulWidget {
  TeachCourse teachCourse;
  AssignmentPage({required this.teachCourse});
  @override
  _AssignmentPage createState() => _AssignmentPage(teachCourse: teachCourse);
}

class _AssignmentPage extends State<AssignmentPage>{
  TeachCourse teachCourse;
  _AssignmentPage({ required this.teachCourse});
  List<Assignment> _assignments = [];

  @override
  void initState() {
    super.initState();
    getAssignments();
  }

  void getAssignments()  async{
    final assignments = await AssignmentApi.getAssignments(this.teachCourse.teachCourseId);
    setState(() {
      _assignments = assignments;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Semester ${teachCourse.term}/${teachCourse.year}')),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 30),
                child: TeachCourseHeader(
                  teachCourse: teachCourse,
                )),
            Expanded(child: ListView(
              children: _assignments.map((e){
                return InkWell(
                  child: ListTile(
                      title: Text(
                          '${e.assignmentName}'),
                      subtitle: Text('FullScore ${e.fullScore.toString()}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async{
                              print('Edit Assignment');
                              return showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: const Text('Edit'),
                                        content: AssignmentEditForm(assignment: e, getAssignments: getAssignments,)
                                    );
                                  }
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              print('Delete Assignment');
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    content: Text('Do you want to Delete ${e.assignmentName}'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>  Navigator.pop(context, 'Cancel'),
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () async{
                                            final _delAssignmentSuccess = await AssignmentApi.deleteAssignment(e.assignmentId);
                                            if(_delAssignmentSuccess){
                                              setState(() {
                                                _assignments.removeWhere((element) => element.assignmentId == e.assignmentId);
                                              });
                                            }
                                            Navigator.pop(context, 'Cancel');
                                          },
                                          child: Text('Confirm'))
                                    ],
                                  ));
                            },
                          )
                        ],
                      )
                  ),
                  onTap: (){
                    print('Look Student Assignments');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentAssignmentPage(teachCourse: teachCourse,assignment: e,)
                        )
                    );
                  },
                );
              }).toList(),)
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.all(10),
          child: FloatingActionButton(
            onPressed: () async{
              print('create assignment');
              return showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text('New Assignment'),
                        content: AssignmentAddForm(teachCourse: teachCourse, getAssignments: getAssignments)
                    );
                  }
              );
            },
            child: Icon(Icons.add),
          ),
        )
    );
  }

}