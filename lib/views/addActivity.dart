import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

import '../utils/saatSec2.dart';
import 'daily.dart';
import '../utils/mybottombar.dart';

class addActivity extends StatefulWidget {
  const addActivity({Key? key}) : super(key: key);

  @override
  State<addActivity> createState() => _addActivityState();
}

class _addActivityState extends State<addActivity> {

  TextEditingController header = TextEditingController();
  TextEditingController details = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  List<Color> circleColors = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.cyan,
    Colors.pink,
  ];
  List<bool> isTappedList = List.filled(10, false);
  int selectedCircleIndex = -1;
  var selectedColor;
  bool isCompleted = false;

  void onTap(int index) {
    setState(() {
      if (selectedCircleIndex != -1) {
        isTappedList[selectedCircleIndex] = false;
      }
      isTappedList[index] = true;
      selectedCircleIndex = index;
    });
  }

  int selectedHour = 1;

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ADD ACTIVITY',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: screenSize.width - 50,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Hedef'),
                          ],
                        ),
                        TextFormField(
                          controller: header,
                          decoration: InputDecoration(
                            hintText: 'Hedef Başlığı',
                            hintStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: screenSize.width - 50,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Hedef Detayları'),
                          ],
                        ),
                        TextFormField(
                          controller: details,
                          decoration: InputDecoration(
                            hintText: 'Detay giriniz',
                            hintStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Renk Seç'),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                          (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = circleColors[index];
                            isTappedList =
                                List.filled(circleColors.length, false);
                            isTappedList[index] = true;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isTappedList[index]
                                ? circleColors[index].withOpacity(0.8)
                                : circleColors[index],
                          ),
                          child: isTappedList[index]
                              ? Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Saat seçiniz: (sağa veya sola kaydır)'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        24,
                            (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              SaatSec2.secilenSayi = index;
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: SaatSec2.secilenSayi == index
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Tarih seçiniz:'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 300, width: 300,
                    child: CalendarCarousel(
                      onDayPressed: (DateTime date, List events) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      selectedDateTime: selectedDate,
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){

                  FirebaseFirestore.instance.collection('users')
                      .doc(auth.currentUser?.uid).collection('activities')
                      .add({
                    'activity_name': header.text,
                    'activity_details': details.text,
                    'color': selectedColor.toString(),
                    'activity_hour': selectedHour,
                    'activity_date': selectedDate,
                    'userID' : auth.currentUser?.uid,
                    'hours' : 0,
                    'minutes' : 0,
                    'seconds' : 0,
                    'elapsedTime' : 0,
                    'isCompleted' : isCompleted,
                  });

                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Daily(),
                      ));


                }, child: Text('Tamamla'))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
