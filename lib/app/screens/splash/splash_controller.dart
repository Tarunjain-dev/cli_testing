import 'dart:async';
import 'package:cli_testing/app/constants/firebase_constants.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{

  // checking currently user is login or not?
  isLogin(){
    // checking currently user is login or not?
    final user = firebaseAuth.currentUser;
    if(user != null){
      // user has login to the app.
      Timer(Duration(seconds: 3), ()=>Get.offNamed("/home"));
    }else{
      // user is not login to the app.
      Timer(Duration(seconds: 3), ()=> Get.offNamed("/login"));
    }
  }

}