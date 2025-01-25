import 'package:cli_testing/app/screens/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  SignupController signupController = SignupController();
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

  // Signup method login here...
  void signUp(){
    if(_formKey.currentState!.validate()){
      signupController.signup(
          userEmail: emailController.text.toString(),
          userPassword: passwordController.text.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp Screen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.purple,

      ),
      /// Body
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
                        onFieldSubmitted: (value){

                        },
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
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.purple),),
                      onPressed: () => signUp(),
                      child: signupController.isLoading.value ?
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: CircularProgressIndicator( color: Colors.white,),
                      ) :
                      Text("SignUp", style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18, color: Colors.white),),
                    ),
                  ),
               ),

              SizedBox(height: 8),

              /// Already have an account? login button..
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),),
                  InkWell(
                    onTap: (){
                      // Navigate to back to login screen
                      Navigator.pop(context);
                    },
                    child: Text(" Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),),
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
