import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:firebase_the_tech_course/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {


  bool loading = false;
  File? _image;         // <-- This Pic image store File


  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance; 
  DatabaseReference database = FirebaseDatabase.instance.ref("Post");






  Future getImageGallery() async {           // <-- Use Imagepicker Method

    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().tostMessage("No Image Selected");
        print("No Image picked");
      }

    });
    

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("upload image "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    getImageGallery();   // <-- This call getImageGallery Method
                  },

                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(border: Border.all()),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Center(
                            child: Icon(Icons.image),
                          ),

                  ),

                ),
              ),


              SizedBox(
                height: 40,
              ),


              RoundButton(title: "Upload",loading: loading,   // <-- This Call RoundButton class

                  onTap: () async {

                    setState(() {
                      loading = true;
                    });

                       firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.        // <-- This Firebase Image Upload code Method
                        ref('/myimage/' + DateTime.now().microsecondsSinceEpoch.toString());
                         firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

                      Future.value(uploadTask).then((value) async {
    
                      var newUrl = await ref.getDownloadURL();   // <-- Upload image Url get and Store

                      database      // <-- FirebaseDatabase Reference call
                        .child('1')
                        .set({'id': 12234, 'title': newUrl.toString()}).
                        then((value) {

                        Utils().tostMessage("Uploaded");
                        setState(() {
                          loading = false;
                        });

                      }).onError((error, stackTrace) {

                        setState(() {
                          loading = false;
                        });

                      });




                    }).onError((error, stackTrace) {
                      Utils().tostMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });


                  })  // RoundButton



            ]), // Column

      ),


    );
  }
}
