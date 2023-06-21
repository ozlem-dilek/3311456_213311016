import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/selectProfilePhoto.dart';
import 'package:studyapp2/models/post_model.dart';
import 'package:studyapp2/services/activity_service.dart';
import 'package:studyapp2/services/post_service.dart';
import '../models/activity_model.dart';
import '../services/mybottombar.dart';
import '../views/user_settings.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ActivityService _activityService = ActivityService();
  String? username = FirebaseAuth.instance.currentUser!.displayName;
  String? nickName;
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  String? text;
  String? imagePath;
  TextEditingController textcontrol = TextEditingController();
  List<Post> userPosts = [];
  PostService _postService = PostService();
  Color tileColor = Colors.white;
  bool isTapped = true;

  Future<DocumentSnapshot> getUserData() async {
    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get();

    if (userSnapshot.exists) {
      return userSnapshot;
    } else {
      throw Exception("Kullanıcı bulunamadı");
    }
  }

  Future<List<Post>> getUserPosts() async {
    userPosts = await _postService.getUserPosts(userID!);
    return userPosts;
  }

  void onDoubleTap() async {
    String? selectedImagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectPhotoPage()),
    );
    if (selectedImagePath != null) {
      setState(() {
        imagePath = selectedImagePath;
      });
    }
  }



  void _sharePost() async {
    if (text != null) {
      String? userId = userID;
      String? name = username;
      String? profilePicture = '';
      String photoUrl = '';

      DateTime timestamp = DateTime.now();

      Post post = Post(
        userId: userID!,
        username: username!,
        profilePicture: profilePicture,
        text: text!,
        photoUrl: photoUrl,
        timestamp: timestamp,
        Id: _postService.postsCollection.doc().id
      );
      await _postService.createPost(post);
    }
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 30,
            backgroundColor: Colors.white,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => userSettings()),
                    );

                },
                    icon: Icon(Icons.settings),
                    iconSize: 30,
                    color:Color.fromRGBO(142, 159, 218, 1.0)
                ),


              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    shadowColor: Colors.white,
                    elevation: 5,
                    child: Container(
                      height: 170,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: GestureDetector(
                              onDoubleTap: onDoubleTap,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (imagePath != null)
                                    Image.file(
                                      File(imagePath!),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    Icon(Icons.account_circle_sharp, size: 150),
                                ],
                              ),
                            ),


                          ),
                          Flexible(
                            flex: 3,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FutureBuilder<DocumentSnapshot>(
                                        future: getUserData(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text('Hata: ${snapshot.error}'),
                                            );
                                          } else {
                                            if (snapshot.hasData &&
                                                snapshot.data!.exists) {
                                              username = snapshot.data!['name'];
                                              nickName = snapshot.data!['nickname'];
                                              return Row(
                                                children: [
                                                  Text('$username'),
                                                ],
                                              );
                                            } else {
                                              return const Center(
                                                child: Text('Kullanıcı bulunamadı'),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('data'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: screenSize.width - 30,
                    child: TextFormField(
                      controller: textcontrol,
                      decoration: InputDecoration(
                        labelText: 'Write something...',
                      ),
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _sharePost,
                    child: Text('Share'),
                  ),
                  SingleChildScrollView(
                    child: FutureBuilder<List<Post>>(
                      future: getUserPosts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Hata: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          List<Post> userPosts = snapshot.data!;
                          return SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: userPosts.length,
                              itemBuilder: (context, index) {
                                Post post = userPosts[index];

                                return Dismissible(
                                  key: Key(post.Id),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) async {
                                    await _postService.deletePost(post.Id);
                                    setState(() {
                                      userPosts.removeAt(index);
                                    });
                                    getUserPosts();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Paylaşım silindi"),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    leading:imagePath == null
                                        ? Icon(Icons.account_circle_sharp, size: 40,)
                                        : Image.file(File(imagePath!)),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('${username}',
                                            style: TextStyle(
                                              fontSize: 15
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Text(post.text,
                                        style: TextStyle(fontSize: 23),),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('${post.timestamp}',
                                        style: TextStyle(
                                          fontSize: 10
                                        ),),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Text('Henüz paylaşım yok'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomBar(),
        ),
      ),
    );
  }
}
