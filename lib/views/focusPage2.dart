import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'focusPage.dart';
import 'pick.dart';


class focusPage2 extends StatefulWidget {
 final time;
 focusPage2({Key? key,  required this.time}) : super(key: key);

  @override
  State<focusPage2> createState() => _focusPage2State();
}

class _focusPage2State extends State<focusPage2> {

  late CountDownController _kontrol;
  int? saat;

  @override
  void initState() {
    super.initState();
    _kontrol = CountDownController();
    saat = widget.time;
    print('saat: $saat');
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularCountDownTimer(
                width: 300,
                height: 300,
                duration: Duration(hours: saat==null ? saat = 2 : saat!).inSeconds,
                fillColor: Colors.purple,
                ringColor: Colors.purple.withOpacity(0.2),
                backgroundColor: Colors.purple.withOpacity(0.5),
                autoStart: false,
                strokeWidth: 20,
                textStyle: TextStyle(fontSize: 30),
                controller: _kontrol,
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){_kontrol.isPaused ? _kontrol.resume() : _kontrol.start();}, icon: Icon(Icons.play_arrow),color: Colors.purple,),
                  IconButton(onPressed: (){_kontrol.pause();}, icon: Icon(Icons.pause), color: Colors.purple),
                  IconButton(onPressed: (){_kontrol.restart(duration: Duration(hours: saat!).inSeconds);}, icon: Icon(Icons.restore), color: Colors.purple),
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
                              onPressed: ()
                              {

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Pick(),
                                  ));
                              },

                            ),
                          ],
                        );

                      },);},
                    icon: Icon(Icons.cancel_rounded), color: Colors.purple

                  )


                ],
              ),
            ],
          ),
        )


    );
  }
}
