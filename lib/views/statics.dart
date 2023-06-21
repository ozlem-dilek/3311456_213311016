import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/services/mybottombar.dart';

import '../models/activity_model.dart';
import '../services/activity_service.dart';

class Statics extends StatefulWidget {
  const Statics({Key? key}) : super(key: key);

  @override
  State<Statics> createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  late String userID;
  late Future<List<Activity>> userActivities;
  final ActivityService activityService = ActivityService();

  @override
  void initState() {
    super.initState();
    getUserID();
    getUserActivities();
  }

  void getUserID() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userID = user.uid;
    }
  }

  void getUserActivities() {
    userActivities = activityService.getUserActivities(userID);
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Activity>>(
        future: userActivities,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(height: 100,),
                Container(
                  height:  MediaQuery.of(context).size.height * 0.7,
                  child: BarChart(
                    BarChartData(
                      titlesData: FlTitlesData(
                        show: true,
                      ),
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipPadding: EdgeInsets.all(5),
                          tooltipBgColor: Colors.pink,
                          tooltipMargin: 5,

                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final activity = snapshot.data![groupIndex];
                            return BarTooltipItem(
                              '${activity.name}\n${activity.hour} hours',
                              TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ),
                      barGroups: getBarGroups(snapshot.data),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  List<BarChartGroupData> getBarGroups(List<Activity>? activities) {
    if (activities == null || activities.isEmpty) {
      return [];
    }

    final maxHours = activities.map((activity) => activity.hour).reduce((a, b) => a > b ? a : b);

    return List.generate(activities.length, (index) {
      final activity = activities[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: 0,
            color: Colors.blue,
            width: 30, toY: activity.hour.toDouble(),
          ),
        ],
        showingTooltipIndicators: [0],
      );
    });
  }
}
