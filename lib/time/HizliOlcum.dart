import 'dart:async';
import 'package:flutter/material.dart';
class HizliOlcum extends StatefulWidget {
  @override
  _HizliOlcumState createState() => _HizliOlcumState();
}

class _HizliOlcumState extends State<HizliOlcum> {
  Timer? _zamanlayici;
  int _sayac = 0;
  static String? gecenSure;

  void _baslat() {
    _zamanlayici = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _sayac++;
      });
    });
  }

  void _durdur() {
    if (_zamanlayici != null) {
      _zamanlayici!.cancel();
      _zamanlayici = null;
    }
  }

  void _sifirla() {
    if (_zamanlayici != null) {
      _zamanlayici!.cancel();
      _zamanlayici = null;
    }
    setState(() {
      _sayac = 0;
    });
  }



  String getTimerText(int sayac) {
    Duration duration = Duration(seconds: sayac);
    String sayicevir(int n) => n.toString().padLeft(2, "0");
    String dakikacevir = sayicevir(duration.inMinutes.remainder(60));
    String saniyecevir = sayicevir(duration.inSeconds.remainder(60));
    return "${sayicevir(duration.inHours)}:$dakikacevir:$saniyecevir";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("how long can you focus?"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              getTimerText(_sayac),
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _baslat,
                  child: Text("ready!"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _durdur,
                  child: Text("take a break"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _sifirla,
                  child: Text("reset"),
                ),



              ],
            ),
          ],
        ),
      ),
    );
  }
}
