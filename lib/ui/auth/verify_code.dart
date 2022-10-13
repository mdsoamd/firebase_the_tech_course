import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_the_tech_course/ui/posts/post.dart';
import 'package:firebase_the_tech_course/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verificationCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),

            TextFormField(
              keyboardType: TextInputType.number,
              controller: verificationCodeController,
              maxLength: 6,
              decoration: InputDecoration(
                
                hintText: "6 digit code"),
            ),

            SizedBox(
              height: 80,
            ),

            RoundButton(
                title: "Verify",loading: loading,onTap: () async {

                  setState(() {
                    loading = true;
                  });

                  final credential = PhoneAuthProvider.credential(        // <-- This phone Authentication  code
                      verificationId: widget.verificationId,
                      smsCode:verificationCodeController.text.toString());

                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => PostScreen()));

                  } catch (e) {
                    Utils().tostMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
