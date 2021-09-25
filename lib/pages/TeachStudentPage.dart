import 'package:flutter/material.dart';
import 'package:untitled/apis/TeachStudentApi.dart';
import 'package:untitled/companants/ImportCSVForm.dart';
import 'package:untitled/companants/TeachCourseHeader.dart';
import 'package:untitled/models/TeachCourse.dart';
import 'package:untitled/models/TeachStudent.dart';

class TeachStudentPage extends StatefulWidget {
  TeachCourse teachCourse;
  Function getTeachStudents;
  TeachStudentPage({required this.teachCourse, required this.getTeachStudents});

  @override
  _TeachStudentPage createState() => _TeachStudentPage(teachCourse: teachCourse,getTeachStudents: getTeachStudents);
}

class _TeachStudentPage extends State<TeachStudentPage> {
  TeachCourse teachCourse;
  Function getTeachStudents;
  _TeachStudentPage({required this.teachCourse, required this.getTeachStudents});
  List<TeachStudent> _teachStudents = [];

  @override
  void initState() {
    _getTeachStudents();
  }

  void _getTeachStudents() async{
    final results = await TeachStudentApi.getTeachStudents(teachCourse.teachCourseId);
    setState(() {
      _teachStudents = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Semester ${teachCourse.term}/${teachCourse.year}'),
        ),
        body: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20.0),
                child: TeachCourseHeader(teachCourse: teachCourse)),
            Expanded(child: ListView(
              children: _teachStudents.map((e){
                return ListTile(
                    title: Text(
                        '${e.firstName} ${e.lastName} ( Sec ${e.secNo.toString()})'),
                    subtitle: Text(e.studentId.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async{
                        final _deleteSuccess = await TeachStudentApi.deleteTeachStudents(e.teachStudentId);
                        if(_deleteSuccess){
                          getTeachStudents();
                          _getTeachStudents();
                        }
                      },
                    )
                );
              }).toList(),)
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text('Section number'),
                      content: ImportCSVForm(teachCourse: teachCourse, getTeachStudents: _getTeachStudents,)
                  );
                },
              );

            },
            child: Icon(Icons.file_download)
        )
    );
  }
}