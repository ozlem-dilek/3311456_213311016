import 'package:flutter/cupertino.dart';

import '../models/activity_model.dart';

class EditActivityPage extends StatefulWidget {
  const EditActivityPage({Key? key, required this.activity}) : super(key: key);
final Activity activity;
  @override
  State<EditActivityPage> createState() => _EditActivityPageState();
}

class _EditActivityPageState extends State<EditActivityPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
