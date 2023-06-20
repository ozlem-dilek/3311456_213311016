import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/loginPage.dart';
import '../services/auth_service.dart';

class Createacc extends StatefulWidget {
  const Createacc({Key? key}) : super(key: key);

  @override
  State<Createacc> createState() => _CreateaccState();
}

class _CreateaccState extends State<Createacc> {

  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController  nicknameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  Future<void> _registerWithGoogle() async {
    UserCredential? userCredential = await _authService.signInWithGoogle();
    if (userCredential != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(172, 189, 248, 1.0),
      body: Stack(
          children: [
          Image(image: const AssetImage('lib/assets/createacc.png'),
      width: screenSize.width,
    ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenSize.width/3+40,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Name',

                        ),

                      )

                  ),
                  SizedBox(width: 20),
                  SizedBox(
                      width: screenSize.width/3+40,
                      child: TextFormField(
                        controller: nicknameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                            hintText: 'Nickname'

                        ),
                      )

                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: screenSize.width/3+40,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'E-mail'
                        ),

                      )

                  ),
                  SizedBox(width: 20),
                  SizedBox(
                      width: screenSize.width/3+40,
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password'
                        ),
                        obscureText: true,
                      )

                  ),
                ],
              ),
              SizedBox(height: 10,),

              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  String nickname = nicknameController.text.trim();
                  String name = nameController.text.trim();

                  QuerySnapshot<Object?> nicknameSnapshot = await usersRef
                      .where('nickname', isEqualTo: nickname)
                      .get();

                  QuerySnapshot<Object?> emailSnapshot = await usersRef
                      .where('email', isEqualTo: email)
                      .get();



                  if (nicknameSnapshot.docs.isNotEmpty ) {
                      showDialog(
                        context: context,
                        builder: (context) {
                        return AlertDialog(
                          title: const Text('Hata'),
                          content: const Text('Bu nickname zaten kullanılıyor.'),
                          actions: [
                          TextButton(
                            onPressed: () {
                            Navigator.pop(context);
                            },
                            child: const Text('Tamam'),
                          ),
                      ],
                      );
                      },
                      );
                      }

                  else if (emailSnapshot.docs.isNotEmpty){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Hata'),
                          content: const Text('Bu e-mail zaten kullanılıyor.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }


                 else if (name.isEmpty || nickname.isEmpty || email.isEmpty || password.isEmpty) {
                    String emptyFields = '';

                    if (name.isEmpty) {
                      emptyFields += 'Name, ';
                    }

                    if (nickname.isEmpty) {
                      emptyFields += 'Nickname, ';
                    }

                    if (email.isEmpty) {
                      emptyFields += 'E-mail, ';
                    }

                    if (password.isEmpty) {
                      emptyFields += 'Password, ';
                    }

                    emptyFields = emptyFields.substring(0, emptyFields.length - 2);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Hata'),
                          content: Text('Lütfen aşağıdaki alanları doldurunuz: $emptyFields.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  else if (!isValidEmail(email)) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Hata'),
                          content: const Text('Geçerli bir e-posta adresi giriniz.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  else {

                  UserCredential? userCredential =
                  await _authService.registerWithEmailAndPassword(email, password);
                  if (userCredential != null) {
                  await usersRef.doc(userCredential.user!.uid).set({
                  'email': email,
                  'nickname': nickname,
                  'name': name,
                  });};

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  }
                },
                child: const Text('Sign Up',
                style: TextStyle(
                  color: Color.fromRGBO(116, 129, 194, 1.0)
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 5,),
              Text('- OR -',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16
              ),),
              ElevatedButton(
                onPressed: _registerWithGoogle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                child: Image.asset('lib/assets/google.png', width: 24, height: 24),
              )
            ],
          ),
          ]
      )
    );
  }
}

bool isValidEmail(String email) {

  final emailRegex =
  RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}