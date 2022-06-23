import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';


class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);
  static String id = 'emailverify';

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {

  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  void initState(){
    user = auth.currentUser!;
    if(user != Null){
      user.sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 2), (timer) {
          checkemailverified();
      });
    }
    super.initState();
  }

  Future<void> checkemailverified() async{
    user = auth.currentUser!;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.pushNamed(context, HomeScreen.id);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("verify your email ${user.emailVerified}"),),
    );
  }
}
