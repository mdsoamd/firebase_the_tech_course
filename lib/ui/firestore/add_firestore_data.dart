
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:firebase_the_tech_course/widgets/round_button.dart';
import 'package:flutter/material.dart';



class AddFireStoreDataScreen extends StatefulWidget {
  const AddFireStoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFireStoreDataScreen> createState() => _AddFireStoreDataScreenState();
}

class _AddFireStoreDataScreenState extends State<AddFireStoreDataScreen> {

 final postController = TextEditingController();
 bool loading = false;
 final firestore = FirebaseFirestore.instance.collection('users');     // <-- This Users collection Create 
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(
              height: 30,
            ),

            TextFormField(
            controller: postController,   
           maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind?",
                border: OutlineInputBorder()
              ),
            ),
            
            SizedBox(
              height: 30,
            ),
            
            RoundButton(title: "Add",loading:loading, onTap: (){

              setState(() {
                loading = true;
              });

              String id = DateTime.now().millisecondsSinceEpoch.toString();
              
              firestore.doc(id).set({                     // <-- This FireStore data add Code and Method
                "title":postController.text.toString(),
                "id":id
              }).then((value){
                Utils().tostMessage("Post Added");
                setState(() {
                  loading = false;
                });
              }).onError((error, stackTrace){
                  Utils().tostMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
              }); 
              
             

            
            })
          ],
        ),
      ),
    );
  }

  
}