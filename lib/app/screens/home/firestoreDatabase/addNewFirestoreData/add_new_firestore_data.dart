import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewFirestoreDataScreen extends StatefulWidget {
  const AddNewFirestoreDataScreen({super.key});

  @override
  State<AddNewFirestoreDataScreen> createState() => _AddNewFirestoreDataScreenState();
}

class _AddNewFirestoreDataScreenState extends State<AddNewFirestoreDataScreen> {
  bool isLoading = false;
  TextEditingController postController = TextEditingController();
  final firestoreRef = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Firestore Data", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 4),
              TextFormField(
                controller: postController,
                decoration: InputDecoration(
                  hintText: "What's in your mind?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2)
                  ),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      // replace 'id' with UID for 'users' collection
                      var id = DateTime.now().microsecond.toString();
                      setState(() => isLoading = true);
                      // add new post backend logic here...
                      firestoreRef.doc(id).set({
                        "title" : postController.text.toString(),
                        "id" : id,
                      }).then((value) {
                        setState(() => isLoading = false);
                        Get.back();
                        Get.snackbar("Post Added Successful", "");
                      }).onError((error, stackTrace) {
                        setState(() => isLoading = false);
                        Get.snackbar(error.toString(), "");
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.purple)
                    ),
                    child: isLoading?
                    Center(child: CircularProgressIndicator(color: Colors.white,)):
                    Text("Add New Post", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)
                ),
              ),
            ],
          ),
        )
    );
  }
}
