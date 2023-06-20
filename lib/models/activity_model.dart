import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String id;
  final String name;
  final String details;
  late final int hour;
  final Timestamp date;
  final String color;
  final int elapsedTime;
  final int hours;
  final int minutes;
  final int seconds;
  bool isCompleted;



  Activity({
    required this.id,
    required this.name,
    required this.details,
    required this.hour,
    required this.color,
    required this.date,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.elapsedTime,
    required this.isCompleted,
  });
}
