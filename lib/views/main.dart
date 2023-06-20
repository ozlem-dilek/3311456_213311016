import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/daily.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      home: Daily(),
    );
  }

}