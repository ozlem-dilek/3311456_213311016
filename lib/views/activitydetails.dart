
import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/models/activity_model.dart';

import 'daily.dart';



class ActivityDetailsPage extends StatefulWidget {
  const ActivityDetailsPage({Key? key, required this.activity,}) : super(key: key);
  final Activity activity;
  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  int elapsedTimeInSeconds = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CountDownController _kontrol = CountDownController();

  void initState() {
    super.initState();
    print('saat: ${widget.activity.hour}');

    startTimer();
  }

  var color;

  StreamSubscription<int>? timerSubscription;
  void dispose() {
    timerSubscription?.cancel();
    super.dispose();
  }
  void startTimer() {
    int totalSeconds = widget.activity.hour * 3600;

    timerSubscription = Stream.periodic(const Duration(seconds: 1), (count) => count)
        .take(totalSeconds + 1)
        .listen((elapsedSeconds) {
      setState(() {
        elapsedTimeInSeconds = elapsedSeconds;
      });

      if (elapsedSeconds == totalSeconds) {
      }
    });
  }

  Future<void> _saveElapsedTime(String elapsedTimeString) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final activityId = widget.activity.id;

      final timeParts = elapsedTimeString.split(':');

      int hours = 0;
      int minutes = 0;
      int seconds = 0;

      if (timeParts.length == 2) {
        minutes = int.parse(timeParts[0]);
        seconds = int.parse(timeParts[1]);
      } else if (timeParts.length == 3) {
        hours = int.parse(timeParts[0]);
        minutes = int.parse(timeParts[1]);
        seconds = int.parse(timeParts[2]);
      }

      int totalSeconds = (hours * 3600) + (minutes * 60) + seconds;

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('activities')
          .doc(activityId)
          .set({
        'elapsedTime': totalSeconds,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds,
      }, SetOptions(merge: true));

      print('Süre kaydedildi: $elapsedTimeString');
    } catch (e) {
      print('Süre kaydedilirken hata oluştu: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

    switch ('${widget.activity.color}') {
      case 'Colors.blue':
        var color = Colors.blue;
        break;
      case 'Colors.cyan':
        color = Colors.cyan;
        break;
      case 'Colors.green':
        color = Colors.green;
        break;
      case 'Colors.yellow':
        color = Colors.yellow;
        break;

      case 'Colors.pink':
        color = Colors.pink;
        break;

      default:
        color = Colors.transparent;
    }

    var screenSize = MediaQuery.of(context).size;


    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('${widget.activity.name}',
                  style: TextStyle(
                    fontSize: 30
                  ),),
                ),
                Container(
                  width: screenSize.width-20,
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                        vertical: BorderSide(
                            width: 5,
                            color: Colors.blue.shade600
                        ),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Details:',
                        style: TextStyle(
                          fontSize: 19
                        ),),
                      ],

                    ),
                  ),

                ),
                Container(
                  height: 100,
                  width: screenSize.width -20,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      vertical: BorderSide(
                        width: 5,
                        color: Colors.blue.shade600
                      ),
                    )
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text('${widget.activity.details}',
                              overflow: TextOverflow.visible,),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Süre: ${widget.activity.hour}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Geçen Süre: ${widget.activity.hours} hours, ${widget.activity.minutes} mins, ${widget.activity.seconds} secs'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularCountDownTimer(
                      width: 300,
                      height: 300,
                      duration: Duration(hours: widget.activity.hour==null ? widget.activity.hour = 1 : widget.activity.hour).inSeconds,
                      fillColor: Colors.blue,
                      ringColor: Colors.blue.withOpacity(0.2),
                      backgroundColor: Colors.blue.withOpacity(0.5),
                      autoStart: false,
                      strokeWidth: 20,
                      textStyle: TextStyle(fontSize: 30),
                      controller: _kontrol,
                      onComplete:(){
                        setState(() {
                          elapsedTimeInSeconds = widget.activity.hour * 3600;
                        });
                      },
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                              _kontrol.isPaused
                              ? _kontrol.resume()
                              : _kontrol.start();
                               var elapsedTime = _kontrol.getTime();
                              print(elapsedTime);

                        }, icon: Icon(Icons.play_arrow),color: Colors.blue,),
                        IconButton(onPressed: (){_kontrol.pause();
                        var elapsedTime = _kontrol.getTime();
                        print(elapsedTime);

                        _saveElapsedTime(elapsedTime!);


                        }, icon: Icon(Icons.pause), color: Colors.blue),
                        IconButton(onPressed: (){_kontrol.restart(
                            duration: Duration(hours: widget.activity.hour!).inSeconds);
                        var elapsedTime = _kontrol.getTime();
                        _saveElapsedTime(elapsedTime!);
                          }, icon: Icon(Icons.restore), color: Colors.blue),
                        IconButton(onPressed: (){

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("close stopwatch"),
                                content: Text("are you sure?"),
                                actions: [
                                  TextButton(
                                    child: Text("no"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("yes"),
                                    onPressed: () {
                                      setState(() {
                                        var elapsedTime = _kontrol.getTime();
                                        _saveElapsedTime(elapsedTime!);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Daily(),
                                            ));
                                      },
                                      );
                                    }
                                  ),
                                ],
                              );

                            },);},
                            icon: Icon(Icons.cancel_rounded), color: Colors.blue

                        )


                      ],
                    ),
                  ],
                ),
              ],


            ),
          ),
        ),
      ),

    );
  }
}
