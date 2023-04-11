import 'package:flutter/material.dart';
import 'package:studyapp2/home/begin.dart';

void main() {
  runApp(const StudyApp());
}

class StudyApp extends StatelessWidget {
  const StudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Begin(),
    );
  }

}

