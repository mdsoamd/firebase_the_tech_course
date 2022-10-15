import 'package:firebase_the_tech_course/ui/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_the_tech_course/ui/auth/login_screen.dart';
import 'package:firebase_the_tech_course/ui/posts/add_post.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:flutter/cupertino.dart';


class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {

final _auth = FirebaseAuth.instance;
 final editController = TextEditingController();


  void logout() {       //  <-- this logout Method code
    _auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }).onError((error, stackTrace) {
      Utils().tostMessage(error.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore "),
        actions: [
          IconButton(
              onPressed: () {
                logout(); // <-- This Call LogOut Method
              },
              icon: Icon(Icons.login_outlined)),
          SizedBox(
            width: 10,
          )
        ],
      ),


      body: Column(
        children: [
          
          SizedBox(
            height: 20,
          ),

          // Expanded(
          //     child: StreamBuilder(                 // <-- Yah Data Show kerne ka durra Tarika   (Stap 2  Data Display Method)
          //   stream: ref.onValue,
          //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {

          //     if (!snapshot.hasData) {

          //       return CircularProgressIndicator();

          //     } else {

          //       Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic> list = [];   // <-- This All Data Store List
          //       list.clear();
          //       list = map.values.toList();

          //       return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(list[index]['title']),
          //               subtitle: Text(list[index]['id']),
          //             );
          //           });
          //     }
          //   },
          // )),




          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Post"),
                );
              })
          )
        ],
      ), // Column



      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFireStoreDataScreen()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<dynamic> showMyDialog(String title, String id) async {    // <-- This Send data receive --> title and --> id

    editController.text = title;      // <-- This code Old data Store TextField 

    return showDialog(
        context: context,builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancal")),

              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: Text("Update"))
            ],
          );
        });
  }
}