import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_the_tech_course/ui/auth/login_screen.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:firebase_the_tech_course/widgets/round_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordlController = TextEditingController();
  final _fomekey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordlController.dispose();
  }



  void signup() {               // <-- Firebase SignUp code

    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim().toString(),
            password: passwordlController.text.trim().toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().tostMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Form(
                key: _fomekey,
                child: Column(
                  children: [


                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.alternate_email)),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        } else if (!value.contains("@")) {
                          return "Plrase Enter valid Email ";
                        }
                        return null;
                      }),
                    ),


                    SizedBox(
                      height: 10,
                    ),


                    TextFormField(
                      controller: passwordlController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password", prefixIcon: Icon(Icons.key)),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      }),
                    ),
                  ],
                )),


            SizedBox(
              height: 50,
            ),


            RoundButton(
              title: "Sign Up",
              loading: loading,
              onTap: (() {
                if (_fomekey.currentState!.validate()) {

                  signup();  // <-- This call signup Method
                }
              }),
            ),


            SizedBox(
              height: 30,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                
                TextButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
                    },

                    child: Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
