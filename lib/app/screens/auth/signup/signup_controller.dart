import 'package:cli_testing/app/constants/firebase_constants.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{

  var isLoading = false.obs;

  // signup() method
  signup({required String userEmail, required String userPassword}){
    isLoading.value = true;
    // Signup backend code here...
    firebaseAuth.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    ).then((value){
      // if sign-up process completes, then execute "then" BlocK.
      isLoading.value = false;
    }).onError((error, stackTrace) {
      // in case of any error or exception to catch here....
      Get.snackbar("Signup Error:", error.toString());
      isLoading.value = false;
    },);
  }

}