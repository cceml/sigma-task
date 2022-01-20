import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sigmatask/index.dart';
import 'package:sigmatask/signup.dart';

class RegisterP extends StatefulWidget {
  const RegisterP({Key? key}) : super(key: key);

  @override
  _RegisterPState createState() => _RegisterPState();
}

class _RegisterPState extends State<RegisterP> {
  //---registerP

  late String email, password;
//-------
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  onChanged: (enterMail) {
                    setState(() {
                      email = enterMail;
                    });
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
                    prefixIcon: (Icon(
                      Icons.email,
                      color: Colors.white,
                    )),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onChanged: (enterPassword) {
                    setState(() {
                      password = enterPassword;
                    });
                  },
                  validator: (enterPassword) {
                    return enterPassword!.length >= 6
                        ? null
                        : "Your Password needs to be at least 6 characters long. ";
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
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child: const Text("Continue"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LoginP()));
                    },
                    child: const Text(
                      "Already have an account? Sign in.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----e mail and password control
  void signIn() {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        Fluttertoast.showToast(msg: "Welcome");
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginP()));
      }).catchError((wrong) {
        //------wrong message
        Fluttertoast.showToast(msg: "WRONG!".toString());
      });
    }
  }
}
