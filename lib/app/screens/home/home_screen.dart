// Home Screen ---> Firebase Realtime Database
import 'package:cli_testing/app/screens/home/home_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeController homeController = Get.put(HomeController());
  final databaseRef = FirebaseDatabase.instance.ref("Post");
  TextEditingController searchController = TextEditingController();
  TextEditingController editPostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home : Realtime Database List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),),
        backgroundColor: Colors.purple,
        actions: [
          // Add new post button
          IconButton(
            onPressed: ()=> Get.toNamed("/addNewPost"),
            icon: Icon(Icons.add,size: 24,color: Colors.white,),
          ),

          // logout button
          IconButton(
            onPressed: ()=> homeController.signOut(),
            icon: Icon(Icons.logout_rounded,size: 24,color: Colors.white,),
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
              //searchbar
              TextFormField(
                controller: searchController,
                onChanged: (String value) {
                  // jub bhi search field me kuch bhi change hoga toh, state rebuild hogi.
                  setState(() {});
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search_rounded,size: 20,),
                  hintText: "Search Post Here...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2)
                  ),
                ),
              ),

              /// Firebase Realtime Database Fetch list.
              Expanded(
                child: StreamBuilder(
                    stream: databaseRef.onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(color: Colors.purple));
                      }
                      else {
                        // Mapping
                        Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
                        List<dynamic> list = [];
                        list = map.values.toList();
                        return ListView.builder(
                          itemCount: snapshot.data!.snapshot.children.length,
                          itemBuilder: (context, index) {
                            final title = list[index]["title"].toString();
                            if(searchController.text.isEmpty){
                              return ListTile(
                                title: Text(list[index]["title"].toString()),
                                subtitle: Text(list[index]["id"].toString()),
                                trailing: PopupMenuButton(
                                    icon: Icon(Icons.more_vert),
                                    itemBuilder: (context) => [
                                      //Edit Post
                                      PopupMenuItem(
                                          value: 1,
                                          child: ListTile(
                                            onTap: (){
                                              Navigator.pop(context);
                                              editPostDialogue(title: title, id: list[index]["id"].toString());
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
                                            databaseRef.child(list[index]["id"].toString()).remove();
                                          },
                                          leading: Icon(Icons.delete),
                                          title: Text("Delete"),
                                        ),
                                      ),
                                    ],
                                ),
                              );
                            }else if(title.toLowerCase().contains(searchController.text.toLowerCase().toString())){
                              return ListTile(
                                title: Text(list[index]["title"].toString()),
                                subtitle: Text(list[index]["id"].toString()),
                                trailing: PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context) => [
                                    // Edit Post
                                    PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: (){
                                          Navigator.pop(context);
                                          editPostDialogue(title: title, id: list[index]["id"].toString());
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
                                          databaseRef.child(list[index]["id"].toString()).remove();
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text("Delete"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }else{
                              return null;
                            }
                          },
                        );
                      }
                    },
                ),
              ),

              /// Firebase Database navigation...
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      // Navigate and try Firebase FireStore Database and its CRUD operation.
                      Get.toNamed("/firestoreDatabaseList");
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.purple)
                    ),
                    child: Text("Firebase Firestore Database",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
                ),
              ),
              SizedBox(height: 10),
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
                  databaseRef.child(id).update({
                    "title": editPostController.text.toString(),
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
