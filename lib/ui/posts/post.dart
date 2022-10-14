import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_the_tech_course/ui/auth/login_screen.dart';
import 'package:firebase_the_tech_course/ui/posts/add_post.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("Post");
  final searchFilter = TextEditingController();




  void logout() {                      //  <-- this logout Method code
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
        title: Text("Post"),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder()
              ),
              onChanged: ((String value) {
                setState(() {
                  
                });
              }),
            ),
          ),



          Expanded(
              child: StreamBuilder(                 // <-- Yah Data Show kerne ka durra Tarika   (Stap 2  Data Display Method)
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {

              if (!snapshot.hasData) {
                
                return CircularProgressIndicator();

              } else {

                Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
                List<dynamic> list = [];   // <-- This All Data Store List
                list.clear();
                list = map.values.toList();

                return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(list[index]['title']),
                        subtitle: Text(list[index]['id']),
                      );
                    });
              }
            },
          )),



          Expanded(
            child: FirebaseAnimatedList(           // <-- Yah Data Show kerne ka Pahla Tarika    (Stap 1 Data Display Method)
                query: ref,
                defaultChild: Center(child: Text("Loading")),
                itemBuilder: (context, snapshot, animation, index) {

                  final title = snapshot.child("title").value.toString();
                  
                  if(searchFilter.text.isEmpty){
                    return ListTile(
                    title: Text(snapshot.child("title").value.toString()),
                    subtitle: Text(snapshot.child("id").value.toString()),
                  );
                  }else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString())){    // <--This Data Filter Code 
                     return ListTile(
                    title: Text(snapshot.child("title").value.toString()),
                    subtitle: Text(snapshot.child("id").value.toString()),
                  );
                  }else{
                    return Container();
                  }
                  
                  
                }),
          )
        ],


      ), // Column



      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
