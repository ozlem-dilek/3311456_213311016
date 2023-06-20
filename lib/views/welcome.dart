import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/createaccount.dart';
import 'package:studyapp2/views/loginPage.dart';


class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(150, 146, 237, 1.0),
      body: Stack(
        children: [
          Image(image: AssetImage('lib/assets/Welcome-2.png'),
          width: screenSize.width,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width:screenSize.width-30,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(onPressed: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                          child: Text('Login',
                              style: TextStyle(
                              color: Color.fromRGBO(126, 116, 204, 1.0),
                                fontSize: 20
                              )
                          ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width:screenSize.width-30,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(onPressed: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Createacc()));
                      },
                          child: Text('Create an account',
                              style: TextStyle(
                                  color: Color.fromRGBO(126, 116, 204, 1.0),
                                  fontSize: 20
                              )
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          )
                      ),
                    ),
                  ),


                ],
              ),
            ),
          )
        ],

      ),
      
      
    );
  }
}


