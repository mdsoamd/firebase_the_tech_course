import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_the_tech_course/ui/auth/verify_code.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:firebase_the_tech_course/widgets/round_button.dart';
import 'package:flutter/material.dart';


class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  final phoneNumberController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80,),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: "+1 234 3455 234"
              ),
            ),
            SizedBox(height: 80,),
            RoundButton(title: "Login",loading: loading, onTap: (){
                setState(() {
                  loading = true;
                });
              
              auth.verifyPhoneNumber(
                phoneNumber: '+91'+ phoneNumberController.text,
                verificationCompleted:(_){
                  setState(() {
                  loading = false;
                });
                }, 
                verificationFailed: (e){
                  Utils().tostMessage(e.toString());
                  setState(() {
                  loading = false;
                });
                },
                 codeSent: (String verificationId,int? token ){
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) => VerifyCodeScreen(verificationId: verificationId)));
                  setState(() {
                  loading = false;
                });
                 }, 
                 codeAutoRetrievalTimeout: (e){
                  Utils().toString();
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