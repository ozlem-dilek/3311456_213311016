import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/timeline_posts.dart';

class TimelineActs extends StatefulWidget {
  const TimelineActs({Key? key}) : super(key: key);

  @override
  State<TimelineActs> createState() => _TimelineActsState();
}

class _TimelineActsState extends State<TimelineActs> {
  bool isActsPageSelected = true;
  CollectionReference users =  FirebaseFirestore.instance.collection('users');
  String? userID = FirebaseAuth.instance.currentUser?.uid;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(172, 189, 248, 1.0),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isActsPageSelected = false;
                });
              },
              icon: Icon(
                Icons.newspaper,
                color: isActsPageSelected ? Colors.pink : Color.fromRGBO(112, 129, 188, 1.0),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isActsPageSelected = true;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TimelinePosts()),
                );

              },
              icon: Icon(
                Icons.toc_sharp,
                color: !isActsPageSelected ? Colors.pink : Color.fromRGBO(112, 129, 188, 1.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
