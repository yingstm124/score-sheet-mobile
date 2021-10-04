import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoresheet/apis/StudentAssignmentApi.dart';
import 'package:scoresheet/companants/ExpandableFab.dart';
import 'package:scoresheet/companants/PreviewImage.dart';
import 'package:scoresheet/companants/TeachCourseHeader.dart';
import 'package:scoresheet/helpers/BaseApi.dart';
import 'package:scoresheet/models/Assignment.dart';
import 'package:scoresheet/models/StudentAssignment.dart';
import 'package:scoresheet/models/TeachCourse.dart';
import 'package:camera/camera.dart';

class StudentAssignmentPage extends StatefulWidget {

  TeachCourse teachCourse;
  Assignment assignment;

  StudentAssignmentPage({required this.teachCourse, required this.assignment});

  @override
  _StudentAssignmentPage createState() => _StudentAssignmentPage(teachCourse: teachCourse, assignment: assignment);

}

class _StudentAssignmentPage extends State<StudentAssignmentPage> {
  TeachCourse teachCourse;
  Assignment assignment;

  _StudentAssignmentPage({required this.teachCourse, required this.assignment});

  List<CameraDescription> cameras = [];
  List<StudentAssignment> _studentAssignments = [];

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _getStudentAssignment();
  }

  Future _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {

      final pickedFile = await _picker.pickImage(
          source: source
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }

  }

  void _getStudentAssignment() async {
    final results = await StudentAssignmentApi.getStudentAssignment(
        assignment.assignmentId);
    setState(() {
      _studentAssignments = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Semester ${teachCourse.term}/${teachCourse.year}')
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 30),
                child: TeachCourseHeader(
                  teachCourse: teachCourse,
                )),
            Expanded(
                child: ListView(
                    children: _studentAssignments.map((e) {
                      return InkWell(
                        child: Card(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  e.img == null ?  Image(image: AssetImage('placeholderImage.png'), height: 150) : Image.network('${BaseApi.getBaseAPI()}${e.img}', height: 150,fit:BoxFit.fill),
                                  ListTile(
                                    title: Text(
                                        '${e.firstName} ${e.lastName} ( Sec ${e
                                            .secNo.toString()})'),
                                    subtitle: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(e.studentId.toString()),
                                        Text((){
                                          if(e.score != null){
                                            return '${e.score}/${assignment.fullScore}';
                                          }
                                          return '0/${assignment.fullScore}';
                                        }())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                        onTap: () {
                          print('click');
                        },
                      );
                    }).toList()
                )
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.all(5),
          child: ExpandableFab(
            distance: 60.0,
            children: [
              ActionButton(
                icon: Icon(Icons.image),
                onPressed: () async {
                  print('uploade image');
                  await _onImageButtonPressed(ImageSource.gallery, context: context);
                  if(_imageFileList != null){
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PreviewImage(getStudentAssignment: _getStudentAssignment, assignment: assignment,image: _imageFileList![0], teachCourse: teachCourse,)
                        )
                    );
                  }
                },
              ),
              ActionButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () async {
                  print('camera');
                  await _onImageButtonPressed(ImageSource.camera, context: context);
                  if(_imageFileList != null){
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PreviewImage(getStudentAssignment: _getStudentAssignment, assignment: assignment,image: _imageFileList![0], teachCourse: teachCourse,)
                        ));
                  }
                },
              )
            ],
          ),
        )
    );
  }

}