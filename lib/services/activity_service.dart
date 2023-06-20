
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activity_model.dart';

class ActivityService {


  Future<List<Activity>> getUserActivities(String userID) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('activities')
        .get();

    List<Activity> activities = [];

    querySnapshot.docs.forEach((document) {
      activities.add(
        Activity(
          id: document.id,
          name: document['activity_name'],
          details: document['activity_details'],
          hour: document['activity_hour'],
          color: document['color'],
          date: document['activity_date'],
          hours: document['hours'],
          minutes: document['minutes'],
          seconds: document['seconds'],
          elapsedTime: document['elapsedTime'],
          isCompleted: document['isCompleted'],
        ),
      );
    });


    return activities;
  }

  Future<void> deleteActivity(String userID, String index) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('activities').doc(index).delete();
    } catch (error) {
      print('Etkinlik silinirken hata oluştu: $error');
      throw Exception('Etkinlik silinirken hata oluştu');
    }
  }




}

