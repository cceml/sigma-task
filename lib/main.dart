import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sigmatask/signin.dart';
import 'package:sigmatask/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //------run
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignIn(),
  ));
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginP();
  }
}
