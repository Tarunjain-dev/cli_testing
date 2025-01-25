import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewPostScreen extends StatefulWidget {
  const AddNewPostScreen({super.key});

  @override
  State<AddNewPostScreen> createState() => _AddNewPostScreenState();
}

class _AddNewPostScreenState extends State<AddNewPostScreen> {

  final databaseRef = FirebaseDatabase.instance.ref("Post");
  bool isLoading = false;
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Post Screen", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
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
                    var id = DateTime.now().microsecond.toString();
                    setState(() => isLoading = true);
                    // add new post backend logic here...
                    databaseRef.child(id).set({
                      "title" : postController.text.toString(),
                      "id" : id
                    }).then((value) {
                      // if successful
                      setState(() => isLoading = false);
                      Get.back();
                    },).onError((error, stackTrace) {
                      // on error
                      setState(() => isLoading = false);
                      Get.back();
                    },);
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
