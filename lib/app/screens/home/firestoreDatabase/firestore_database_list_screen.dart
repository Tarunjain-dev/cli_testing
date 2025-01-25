import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:get/get.dart';

class FirestoreDatabaseListScreen extends StatefulWidget {
  const FirestoreDatabaseListScreen({super.key});

  @override
  State<FirestoreDatabaseListScreen> createState() => _FirestoreDatabaseListScreenState();
}

class _FirestoreDatabaseListScreenState extends State<FirestoreDatabaseListScreen> {

  TextEditingController searchController = TextEditingController();
  TextEditingController editPostController = TextEditingController();
  final firestoreRef = FirebaseFirestore.instance.collection("users").snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Database List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.purple,
        actions: [
          // Add new post button
          IconButton(
            onPressed: (){
              // add new post
              Get.toNamed("/addNewFirestoreData");
            },
            icon: Icon(Icons.add,size: 24,color: Colors.white,),
          ),
        ],
      ),

      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12),
          child: Column(
            children: [
              SizedBox(height: 10),

              /// Firebase FireStore Database Fetch list.
              StreamBuilder<QuerySnapshot>(
                  stream: firestoreRef,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasError){
                      Text("Snapshot has Error");
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data!.docs[index]["title"].toString()),
                            subtitle: Text(snapshot.data!.docs[index]["id"].toString()),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                //Edit Post
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.pop(context);
                                      // Edit Post backend logic
                                      editPostDialogue(
                                          title: snapshot.data!.docs[index]["title"].toString(),
                                          id: snapshot.data!.docs[index]["id"].toString(),
                                      );
                                    },
                                    leading: Icon(Icons.edit),
                                    title: Text("Edit"),
                                  ),
                                ),
                                // Delete Post
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.pop(context);
                                      // Delete Post backend logic
                                      ref.doc(snapshot.data!.docs[index]["id"].toString()).delete();
                                    },
                                    leading: Icon(Icons.delete),
                                    title: Text("Delete"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editPostDialogue({required String title, required String id})async{
    editPostController.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update"),
          content: TextFormField(
            controller: editPostController,
            decoration: InputDecoration(
              hintText: "Edit your post.",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 2)
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: (){
                // Update post backend logic here...
                ref.doc(id).update({
                  "title" : editPostController.text.toString(),
                }).then((value) {
                  Get.back();
                },);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
