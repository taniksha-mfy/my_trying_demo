import 'package:flutter/material.dart';
import 'package:tryingdemo/welcome_screen.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert' show json;
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication.dart';
import 'google_sign_in_button.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Namess',
                    hintText: 'Enter valid mail id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  //SharedPreferences.setMockInitialValues({});
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("email", emailController.text.toString());
                  prefs.setString("password", passwordcontroller.text.toString());
                  prefs.setBool("login",true);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => WelcomeScreen()));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return GoogleSignInButton();
                }
                return CircularProgressIndicator();
              },
            ),
            GestureDetector(
              onTap: (){
                //loginFb();
              },
              child: Container(
                height: 50,
                  child: Image.asset("assets/images/facebook.png")),
            )
          ],
        ));
  }




}
