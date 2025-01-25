import 'package:cli_testing/app/constants/firebase_constants.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  var isLoading = false.obs;

  // login() Method
  login({required String userEmail, required String userPassword}){
    // login backend code here...
    isLoading.value = true;
    firebaseAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
    ).then((value){
      // if login process completed, "then" Block executes
      isLoading.value = false;
      Get.snackbar("Login Successful:", " User $userEmail has successfully login");
      Get.offNamed("/home");
    }).onError((error, stackTrace) {
      // in case of any error, we can catch here.
      Get.snackbar("Login Error:", error.toString());
      isLoading.value = false;
    },);
  }

}
