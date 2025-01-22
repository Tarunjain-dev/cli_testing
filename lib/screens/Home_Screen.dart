import 'package:cli_testing/screens/Auth_Screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseAuth firebaseAuth  = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(onPressed: (){
            // logout backend login here...
            firebaseAuth.signOut().then((value){
              // is signOut was successful
              /// Don't use 'BuildContext's across async gaps...
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace) {
              // is case of any error
              Fluttertoast.showToast(msg: error.toString());
            },);
          }, icon: Icon(Icons.logout_rounded,size: 24,color: Colors.white,)),
        ],
      ),
      body: Center(child: Text("Home Screen")),
    );
  }
}
