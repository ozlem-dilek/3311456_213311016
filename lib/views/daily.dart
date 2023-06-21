
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../services/activity_service.dart';
import 'activitydetails.dart';
import 'editactivity.dart';
import '../services/mybottombar.dart';

class Daily extends StatefulWidget {
  const Daily({Key? key}) : super(key: key);

  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  final ActivityService _activityService = ActivityService();
  String? userName;
  String greeting = '';
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  bool isCompleted = false;

  Future<DocumentSnapshot> getUserData() async {
    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      throw Exception("Kullanıcı bulunamadı");
    }
  }

  Future<List<Activity>> getUserActivities() async {
    return _activityService.getUserActivities(userID!);
  }

  @override
  void initState() {
    super.initState();
    setGreeting();
  }

  void setGreeting() {
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    if (5 < currentHour && currentHour < 12) {
      setState(() {
        greeting = 'Good Morning,';
      });
    } else if (11 < currentHour && currentHour < 18) {
      setState(() {
        greeting = 'Good Afternoon,';
      });
    } else {
      setState(() {
        greeting = 'Good Evening,';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Hata: ${snapshot.error}'),
                      );
                    } else {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        userName = snapshot.data!['name'];
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(15, 15, 0, 3),
                                          child: Text(
                                            greeting,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 15, 10, 3),
                                          child: Text(
                                            '  $userName!'.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(15, 3, 10, 10),
                                      child: Text(
                                        'What are you doing today?',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                FutureBuilder<List<Activity>>(
                  future: getUserActivities(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Hata: ${snapshot.error}'),
                      );
                    } else {
                      if (snapshot.hasData) {
                        var activities = snapshot.data!;
                        return Container(
                          child: ListView.builder(
                            itemCount: activities.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var activity = activities[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      setState(() {
                                        activity.isCompleted = !activity.isCompleted;
                                        isCompleted = !isCompleted;
                                      });


                                    }, icon: isCompleted
                                        ? Icon(Icons.check_box_outline_blank_outlined)
                                        : Icon(Icons.check_box, color: Colors.green) ),
                                    Text(activity.name),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('${activity.date.toDate().day}/${activity.date.toDate().month}/${activity.date.toDate().year}'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Goal: ${activity.hour} hour'),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ActivityDetailsPage(activity: activity),
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Seçenekler'),
                                        content: Text('Bu etkinliği silmek veya düzenlemek istiyor musunuz?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              await _activityService.deleteActivity(userID!, activity.id);
                                              List<Activity> updatedActivities = await _activityService.getUserActivities(userID!);

                                              setState(() {
                                                activities = updatedActivities;
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text('Sil'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EditActivityPage(activity: activity),
                                                ),
                                              );
                                            },
                                            child: Text('Düzenle'),
                                          ),

                                        ],
                                      );
                                    },
                                  );
                                },
                                trailing: activity.isCompleted ? Text('Completed') : null,
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('Etkinlik bulunamadı'),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
