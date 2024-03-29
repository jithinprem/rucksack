import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'detscreen/profiledet.dart';
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

  void initState() {
    user = auth.currentUser!;
    if(user != Null){
      user.sendEmailVerification();
      timer = Timer.periodic(Duration(seconds: 2), (timer) {
          checkemailverified();
      });
    }
    super.initState();
  }

  Future<void> checkemailverified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.pushNamed(context, ProfileDet.id);
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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/knot.gif"), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black54, BlendMode.dstATop)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: ClipRRect(
                  child: Image(image: AssetImage('images/mailbox.gif')),
                  borderRadius: BorderRadius.circular(500.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "verify your email ;)",
                style: TextStyle(fontSize: 26, color: Colors.white70, fontFamily: 'Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
