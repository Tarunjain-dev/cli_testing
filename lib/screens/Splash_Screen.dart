import 'dart:async';
import 'package:cli_testing/screens/Auth_Screens/Login_Screen.dart';
import 'package:cli_testing/screens/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // is user login or not? backend Logic here....
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checking currently user is login or not?
    final user = firebaseAuth.currentUser;
    if(user != null){
      // user has login to the app.
      Timer(Duration(seconds: 3), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      });
    }else{
      // user is not login to the app.
      Timer(Duration(seconds: 3), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Firebase Tutorial",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.black),
        ),
      ),
    );
  }
}
