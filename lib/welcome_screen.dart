import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class WelcomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();

}
class _WelcomeScreenState extends State<WelcomeScreen>{
  late SharedPreferences prefs;
  String email="";
  //String password="";
  String profileurl="";

  @override
  void initState() {
    super.initState();
    getSharedPreferenceValues();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(email),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(profileurl),
        ),
        GestureDetector(
          onTap: (){
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("signout"),
          ),
        ),
      ],)),
    );
  }
  getSharedPreferenceValues() async {
    //  debugger();
    //SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email')!;
      profileurl = prefs.getString('profileurl')!;
      //password=prefs.getString('password')!;

    });
  }
}