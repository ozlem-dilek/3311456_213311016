import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/time/Stopwatchs.dart';
import 'package:studyapp2/time/saatSec2.dart';
class SayiSecimi extends StatefulWidget {
  const SayiSecimi({Key? key}) : super(key: key);

  @override
  _SayiSecimiState createState() => _SayiSecimiState();
}

class _SayiSecimiState extends State<SayiSecimi> {

  @override
  Widget build(BuildContext context) {
    int? saat = SaatSec2.secilenSayi;
    return Scaffold(
      appBar: AppBar(
        title: Text("let's focus! pick time"),
        centerTitle: true,
      ),
      body: Center(
        child: SaatSec2()
      ),

      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => myStopwatch(secilenSayi: saat),
                ),
              );
            },
            child: Text("i'm ready!!"),
          ),
        ),
      ),
    );
  }
}
