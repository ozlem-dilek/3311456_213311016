import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/focusPage2.dart';

class focusPage extends StatefulWidget {
  const focusPage({Key? key}) : super(key: key);

  @override
  State<focusPage> createState() => _focusPageState();
}
int? goaltime;

class _focusPageState extends State<focusPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(173, 191, 255, 1.0),
      body: SafeArea(
        child: Stack(
          children: [
            Image(image: const AssetImage('lib/assets/dailybg.png'),
              width: screenSize.width,
              fit: BoxFit.fitWidth,
            ),
            Container(
              color: Colors.white.withOpacity(0.3),
              child: Column(
              children: [
                SizedBox(height: 30,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 50, width: 230,
                    color: Colors.deepPurple.withOpacity(0.8),
                    child: Center(
                      child: Text('Select your time',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white
                      ) ,),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Saat Seçildi'),
                        content: Text('Seçilen saat: ${goaltime}, devam et butonuna tıklayınız'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Tamam'),
                          ),
                        ],
                      );
                    },
                  );
    },
                      child: CupertinoPicker(
                        itemExtent: 50,
                        onSelectedItemChanged: (int index) {
                        goaltime = index;
                        print('Seçilen saat: $goaltime');
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
                        ),
    ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(height: 50, width: 200,
                    child: ElevatedButton(onPressed: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  focusPage2(time: goaltime)),
                      );
                      print(goaltime);

                    },
                      child: Text('Continue',
                      style: TextStyle(
                        fontSize: 20
                      ),),
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 30,)
              ],
          ),
            ),

          ]
        ),
      )

    );}}


