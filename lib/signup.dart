import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sigmatask/index.dart';
import 'package:sigmatask/signin.dart';

class LoginP extends StatefulWidget {
  const LoginP({Key? key}) : super(key: key);
  @override
  _LoginPState createState() => _LoginPState();
}

class _LoginPState extends State<LoginP> {
  //--------LOGIN
  late String email, password;

  //------checked

  var _formcheckedkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Form(
        key: _formcheckedkey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  onChanged: (enterEmail) {
                    email = enterEmail;
                  },
                  validator: (enterMail) {
                    return enterMail!.contains("@") ? null : "Invalid Email";
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "e-Mail",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (enterPassword) {
                    password = enterPassword;
                  },
                  validator: (enterPassword) {
                    return enterPassword!.length >= 6
                        ? null
                        : "Please Check Your Password";
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  signUp();
                },
                child: const Text("LOGIN"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RegisterP()));
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "Create An Account",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//----- mail password check
  void signUp() {
    if (_formcheckedkey.currentState!.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        //login true go home
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => index()), (route) => false);
      }).catchError((wrong) {
        Fluttertoast.showToast(msg: (wrong));
      });
    }
  }
}
