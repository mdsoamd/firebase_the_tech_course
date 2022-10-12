import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_the_tech_course/ui/auth/login_screen.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:flutter/material.dart';




class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
   
 final _auth = FirebaseAuth.instance;
  

 void logout(){      //  <-- this logout Method code 

   _auth.signOut().then((value){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));})
    .onError((error, stackTrace){
       Utils().tostMessage(error.toString());
   });
 }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Post"),
        actions: [
          IconButton(onPressed: (){

           logout();  // <-- This Call LogOut Method

          }, 
          icon: Icon(Icons.login_outlined)),

          SizedBox(width: 10,)
        ],
      ),
    );
  }
}