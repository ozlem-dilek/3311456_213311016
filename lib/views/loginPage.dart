import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/services/signinfunc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(172, 189, 248, 1.0),
      body: Stack(
        children: [
          Image(image: AssetImage('lib/assets/login.png'),
            width: screenSize.width,
         ),
          Padding(
            padding: const EdgeInsets.only(left:10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: screenSize.width-30,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'E-MAIL',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),

                    )),
                SizedBox(height: 5,),
                SizedBox(
                    width: screenSize.width-30,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'PASSWORD',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )
                      ),

                    )),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end ,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();
                            signInWithEmailAndPassword(context, emailController, passwordController, email, password);
                          },
                          child: Text('LOGIN',
                          style: TextStyle(
                            color: Colors.white
                          ),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(116, 129, 194, 1.0)

                          ),
                        ),
                      ),
                    ),
                  ],
                )


              ],
            ),
          )

    ])
    );
  }}

