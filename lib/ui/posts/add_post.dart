import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:firebase_the_tech_course/widgets/round_button.dart';
import 'package:flutter/material.dart';



class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

 final postController = TextEditingController();
 bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Post");
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
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
            ),SizedBox(
              height: 30,
            ),
            RoundButton(title: "Add",loading:loading, onTap: (){

              setState(() {
                loading = true;
              });

              String id = DateTime.now().millisecondsSinceEpoch.toString();   // <--This User id store Database create id variable
              
              databaseRef.child(id).set({                         // <-- This data add code
                "title": postController.text.toString(),
                'id':id
                
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