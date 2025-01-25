import 'package:cli_testing/app/constants/firebase_constants.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  // signOut() Method
  signOut(){
    firebaseAuth.signOut().then((value){
      // is signOut was successful
      Get.offNamed("/login");
    }).onError((error, stackTrace) {
      // is case of any error
      Get.snackbar("Logout Error:", error.toString());
    },);
  }

}