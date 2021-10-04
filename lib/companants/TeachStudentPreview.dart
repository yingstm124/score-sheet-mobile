import 'package:flutter/material.dart';
import 'package:scoresheet/apis/TeachStudentApi.dart';
import 'package:scoresheet/companants/TeachCourseHeader.dart';
import 'package:scoresheet/models/TeachCourse.dart';
import 'package:scoresheet/models/TeachStudent.dart';

class TeachStudentsPreview extends StatefulWidget {
  Function getTeachStudents;
  TeachCourse teachCourse;
  List<TeachStudent> data;
  TeachStudentsPreview({required this.data, required this.teachCourse, required this.getTeachStudents});
  @override
  _TeachStudentsPreview createState() => _TeachStudentsPreview(data: data, teachCourse: teachCourse, getTeachStudents: getTeachStudents);
}

class _TeachStudentsPreview extends State<TeachStudentsPreview>{
  Function getTeachStudents;
  TeachCourse teachCourse;
  List<TeachStudent> data;
  _TeachStudentsPreview({required this.data, required this.teachCourse, required this.getTeachStudents});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
        appBar: AppBar(
          title: Text('Semester ${teachCourse.term}/${teachCourse.year}'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: TeachCourseHeader(teachCourse: teachCourse),
            ),
            Expanded(child: ListView(
              children: data.map((e) {
                return ListTile(
                  title: Text(
                      '${e.firstName} ${e.lastName} ( Sec ${e.secNo.toString()})'),
                  subtitle: Text(e.studentId.toString()),
                );
              }).toList(),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: OutlinedButton(
                    style: style,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 20.0),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () async {
                      print('import');
                      final _importSuccess = await TeachStudentApi.addTeachStudents(teachCourse.teachCourseId, data);
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("import Success!"),
                            content: ListView.builder(
                                itemCount: _importSuccess.length,
                                itemBuilder: (BuildContext context, int index){
                                  return ListTile(
                                      title: Text(_importSuccess[index].studentId),
                                      subtitle: Text(
                                          _importSuccess[index].isRegister
                                              ? 'already inserted'
                                              : 'can not insert'
                                      )
                                  );
                                }),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: Text("OK")
                              ),
                            ],
                          ));
                      Navigator.of(context).pop();
                      await getTeachStudents();
                    },
                    child: const Text('Import'),
                  ),
                )

              ],
            )

          ],
        )
    );


  }

}