import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyapp2/models/motivation_model.dart';
import 'package:studyapp2/services/motivation_service.dart';
import '../models/fake_users.model.dart';
import '../services/fakeuser_service.dart';
import '../services/mybottombar.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  MotivationService motivationService = MotivationService();
  Motivation motivation = Motivation();
  bool isActsPageSelected = true;
  var motivationQuote;
  var quotesAuthor;
  UserService _service = UserService();
  bool? isLoading;
  List<UsersModelData?> users = [];

  @override
  void initState() {
    super.initState();
    motivationService.fetchMotivation().then((value) {

      setState(() {
      motivationQuote = value?.quote;
      quotesAuthor = value?.author;

      });

    });
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

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

          return SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                Flexible(
                  flex:1,
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index){
                      return ListTile(
                        title: Text('${motivationQuote}'),
                      );
                      },

                  ),
                ),
                Flexible(
                  flex:7,
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            "${users[index]!.firstName! + users[index]!.lastName!}"),
                        subtitle: Text('${motivationQuote}'),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index]!.avatar!),
                        ),
                      );
                    },
                  )
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
