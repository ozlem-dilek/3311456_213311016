import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/mybottombar.dart';

class Statics extends StatefulWidget {
  const Statics({Key? key}) : super(key: key);

  @override
  State<Statics> createState() => _StaticsState();
}

class _StaticsState extends State<Statics> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Scaffold(


          bottomNavigationBar: BottomBar(),
        ));
  }
}
