import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/profile/profile.dart';


class Begin extends StatefulWidget {
  const Begin({Key? key}) : super(key: key);

  @override
  State<Begin> createState() => _BeginState();
}

class _BeginState extends State<Begin> {
  TextEditingController kontrol = TextEditingController();
  late String girilenDeger = kontrol.text;
  String? name = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('welcome to study app!',
            style: TextStyle(
              fontSize: 35,
              backgroundColor: Colors.deepPurple.withOpacity(0.3),
              fontStyle: FontStyle.italic
            ),
            ),
            SizedBox(height: 60,),
            TextFormField(
              controller: kontrol,
              decoration: const InputDecoration(
                icon: Icon(Icons.account_circle),
                  hintText: 'how should I call you?'),
                minLines: 1,
                cursorColor: Colors.deepPurple,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },

              onEditingComplete: name!.isEmpty  ? null : ()
              {
                Navigator.push( context,
                    MaterialPageRoute(
                        builder: (context) => Profile(), settings: RouteSettings(
                      arguments: name,))); },

            ),

            ElevatedButton(onPressed: name!.isEmpty  ? null : (){
                Navigator.push( context,
                MaterialPageRoute(
                    builder: (context) => Profile(), settings: RouteSettings(
                  arguments: name,))); },
                child: Text('yes, this is me.')
      )
          ],
        ),
      ),
    );
  }
}