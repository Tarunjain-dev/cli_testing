import 'package:cli_testing/app/screens/auth/login/login_screen.dart';
import 'package:cli_testing/app/screens/auth/signup/signup_screen.dart';
import 'package:cli_testing/app/screens/home/addNewPost/add_new_post_screen.dart';
import 'package:cli_testing/app/screens/home/firestoreDatabase/addNewFirestoreData/add_new_firestore_data.dart';
import 'package:cli_testing/app/screens/home/firestoreDatabase/firestore_database_list_screen.dart';
import 'package:cli_testing/app/screens/home/home_screen.dart';
import 'package:cli_testing/app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes{
  static final initialRoute = "/";

  static final routes = [
    GetPage(name: "/", page: ()=> SplashScreen()),
    GetPage(name: "/login", page: ()=> LoginScreen()),
    GetPage(name: "/signup", page: ()=> SignupScreen()),
    GetPage(name: "/home", page: ()=> HomeScreen()),
    GetPage(name: "/addNewPost", page: ()=> AddNewPostScreen()),
    GetPage(name: "/firestoreDatabaseList", page: ()=> FirestoreDatabaseListScreen()),
    GetPage(name: "/addNewFirestoreData", page: ()=> AddNewFirestoreDataScreen()),
  ];
}













