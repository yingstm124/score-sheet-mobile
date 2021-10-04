import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scoresheet/companants/TeachCourses.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Score Sheet App'),
        ),
        body: Scaffold(
          body: TeachCourses(),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}