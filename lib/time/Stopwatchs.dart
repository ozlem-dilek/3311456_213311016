
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/home/MyHomePage.dart';

class myStopwatch extends StatefulWidget {

  final int? secilenSayi;
  const myStopwatch({required this.secilenSayi});

  @override
  State<myStopwatch> createState() => _myStopwatchState();
}

class _myStopwatchState extends State<myStopwatch> {
  late CountDownController _kontrol;
  int? saat;

  @override
  void initState() {
    super.initState();
    _kontrol = CountDownController();
    saat = widget.secilenSayi;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('you can do it, keep going!', style: const TextStyle(fontSize: 20),),
        centerTitle: true,
      ),
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularCountDownTimer(
              width: 300,
              height: 300,
              duration: Duration(hours: saat==null ? saat = 2 : saat!).inSeconds,
              fillColor: Colors.deepPurple.shade300,
              ringColor: Colors.deepPurple.shade100,
              autoStart: false,
              strokeWidth: 20,
              textStyle: TextStyle(fontSize: 30),
              controller: _kontrol,
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){_kontrol.isPaused ? _kontrol.resume() : _kontrol.start();}, icon: Icon(Icons.play_arrow)),
                IconButton(onPressed: (){_kontrol.pause();}, icon: Icon(Icons.pause)),
                IconButton(onPressed: (){_kontrol.restart(duration: saat);}, icon: Icon(Icons.restore)),
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
                                 {Navigator.of(context).push(
                                     MaterialPageRoute(
                                       builder: (context) => const Goals(),
                                     ));
                                 },
                               
                             ),
                           ],
                         );

                },);},
                  icon: Icon(Icons.cancel_rounded),

                )


              ],
            ),
          ],
        ),
    )

    );
  }
}
