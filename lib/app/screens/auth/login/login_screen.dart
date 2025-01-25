import 'package:cli_testing/app/screens/auth/login/login_controller.dart';
import 'package:cli_testing/app/screens/auth/signup/signup_screen.dart';
import 'package:cli_testing/app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  /// Login backend logic from here...
  void login(){
    if(_formKey.currentState!.validate()){
      loginController.login(
          userEmail: emailController.text.toString(),
          userPassword: passwordController.text.toString()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Email Field
                      Text(" Enter Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                      TextFormField(
                        controller: emailController,
                        onFieldSubmitted: (value){},
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'johndoe@gmail.com',
                          prefixIcon: Icon(Icons.alternate_email),
                          focusedBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.purple,width: 2)
                          ),
                          errorBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.red,width: 2)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.red,width: 2)
                          ),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.black,width: 2)
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      ///Password Field
                      Text(" Enter Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                      TextFormField(
                        controller: passwordController,
                        onFieldSubmitted: (value){},
                        validator: (value){
                          if(value!.isEmpty){
                            return "Enter Password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'password',
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          focusedBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.purple,width: 2)
                          ),
                          errorBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.red,width: 2)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.red,width: 2)
                          ),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.black,width: 2)
                          ),
                        ),
                      ),
                    ],
                  )
              ),

              SizedBox(height: 20),

              /// Login Button.
              Obx(
                ()=> SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.purple),),
                      onPressed: () => login(),
                      child: loginController.isLoading.value ? Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CircularProgressIndicator( color: Colors.white,),
                      ) :
                      Text("Login", style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18, color: Colors.white),)
                  ),
                ),
              ),
              SizedBox(height: 8),

              /// Don't have an account Signup button.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),),
                  InkWell(
                    onTap: (){
                      // Navigate to signup screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    },
                    child: Text(" SignUp", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
