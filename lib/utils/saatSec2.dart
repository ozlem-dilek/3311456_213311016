import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaatSec2 extends StatelessWidget {
  static int? secilenSayi;

  const SaatSec2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoPicker(
      itemExtent: 50,
      onSelectedItemChanged: (int index) {
          SaatSec2.secilenSayi = index;
      },
      children: List.generate(
        24,
            (index) => Center(
          child: Text(
            '$index',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
