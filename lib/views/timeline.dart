import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/mybottombar.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
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
