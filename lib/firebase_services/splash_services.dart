
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_the_tech_course/ui/auth/login_screen.dart';
import 'package:firebase_the_tech_course/ui/firestore/firestore%20_list_screen.dart';
import 'package:firebase_the_tech_course/ui/posts/post.dart';
import 'package:firebase_the_tech_course/ui/upload_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices{

  void isLogin(BuildContext context){

    final _auth = FirebaseAuth.instance;

    final user = _auth.currentUser;

    if(user!=null){   // <-- this check user login 
    
      Timer(const Duration(seconds: 3),() => Navigator.push(context, MaterialPageRoute(builder:(context) => PostScreen())));
    }else{
      Timer(const Duration(seconds: 3),() => Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen())));
    }
    
    
    
    
  }
  
}