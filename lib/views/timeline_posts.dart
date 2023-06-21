import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyapp2/views/timeline_activities.dart';

class TimelinePosts extends StatefulWidget {
  const TimelinePosts({Key? key}) : super(key: key);

  @override
  State<TimelinePosts> createState() => _TimelinePostsState();
}

class _TimelinePostsState extends State<TimelinePosts> {
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

 bool isActsPageSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: posts.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Bir hata oluştu: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var document = snapshot.data!.docs[index];
                var data = document.data() as Map<String, dynamic>;
                var timestamp = data['timestamp'] as Timestamp;
                var date = '${timestamp.toDate().day}/ ${timestamp.toDate().month}/${timestamp.toDate().year}';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.account_circle_sharp, size: 40,),
                    title: Text(data['username'],style: TextStyle(fontSize: 20),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6,),
                        Text(data['text']),
                      ],
                    ),
                    trailing: Text(date),

                  ),
                );
              },
            ),
          );

        },
      ),
    );
  }
}
