import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/addActivity.dart';
import 'package:studyapp2/views/daily.dart';
import 'package:studyapp2/views/focusPage.dart';

import '../services/mybottombar.dart';

class Pick extends StatefulWidget {
  const Pick({Key? key}) : super(key: key);

  @override
  State<Pick> createState() => _PickState();
}

class _PickState extends State<Pick> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
      return Future.value(false);
    },
    child: Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image(image: AssetImage('lib/assets/pick.png'),
              fit: BoxFit.fitHeight,),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(height: 60, width: 250,
                      child: ElevatedButton(onPressed: (){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => focusPage()),
                        );

                      },
                          child: Text('Focus',
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 5
                          ),
                          ),
                          style: ElevatedButton.styleFrom(
                           shadowColor: Colors.purpleAccent,
                            elevation: 4,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purpleAccent.shade400
                          ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: SizedBox(height: 60, width: 250,
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const addActivity()),
                        );

                      },
                        child: Text('Add Activity',
                          style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 5
                          ),

                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.blueAccent,
                            elevation: 4,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blueAccent
                        ),
                      ),
                    ),
                  ),

                ]
              ),
            ),]
        ),
      ),
      backgroundColor: Color.fromRGBO(173, 191, 255, 1.0),
      bottomNavigationBar: BottomBar(),
    ));
  }
}


