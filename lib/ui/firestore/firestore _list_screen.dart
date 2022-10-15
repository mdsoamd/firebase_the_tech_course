import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
final firestore = FirebaseFirestore.instance.collection('users').snapshots();    // <-- This Create Fatch Data 
FirebaseFirestore ref = FirebaseFirestore.instance;                              // <-- This Create Update and Delete data
    


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


          StreamBuilder(                // <-- This Code Firestore Database data Fatch and display Method        (Use StreamBuilder)
            stream: firestore,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

              if(snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();

              if(snapshot.hasError)
              return Text("Some Error");
            
            return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {

              Map<String,dynamic> mapData = snapshot.data!.docs[index].data() as Map<String,dynamic>;   //  <-- This Extra add use full code   (Create Map and Store data)

                return ListTile(   

                  title: Text(snapshot.data!.docs[index]["title"].toString()),  // <-- This Data Display and fatch First Stap

                  subtitle: Text(mapData['id']),  // <-- this data Store Map call 
                  

                  trailing: PopupMenuButton(          // <-- This PopupMenu use code
                          color: Colors.pink[200],
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [

                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                          showMyDialog(snapshot.data!.docs[index]["title"].toString() ,mapData['id']) ;     // <-- This data send title or id  (This call showMyDialog Method )
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text("Eidt"),
                                    )),


                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: (){
                                        Navigator.pop(context);
                                        ref.collection('users').doc(mapData['id']).delete();    // <-- This Data Delete Method code
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text("Delete"),
                                    )
                                  ),



                              ]),                           // <-- This Data Display and fatch Second Stap   (Use mapData)                         
                );
              })
          );
        }
      ),

          
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

                    ref.collection('users').doc(id).update({         // <-- This FireStore Update adta Method code
                      'title': editController.text
                    }).then((value){
                      Utils().tostMessage("Post Updated");
    
                    }).onError((error, stackTrace){
                      Utils().tostMessage(error.toString());
                    });
                  },

                  child: Text("Update"))

                  
            ],
          );
        });
  }





}