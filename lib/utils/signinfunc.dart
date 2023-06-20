
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/daily.dart';

Future<void> signInWithEmailAndPassword(BuildContext context,emailController, passwordController, email, password) async {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  if (email.isEmpty || password.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: const Text('E-posta ve şifre alanları boş olamaz.'),
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
    return;
  }



  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Daily()),
    );
  } catch (e) {
    print('Hata: $e');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: const Text('E-posta veya şifre yanlış.'),
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
}
