import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rucksack/color/colors.dart';
import 'package:toast/toast.dart';
import 'emailverify.dart';
import 'homescreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogSignScreen extends StatefulWidget {
  static String id = 'loginscreen';
  LogSignScreen({Key? key}) : super(key: key);

  @override
  State<LogSignScreen> createState() => _LogSignScreenState();
}

class _LogSignScreenState extends State<LogSignScreen> {
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  final _auth = FirebaseAuth.instance; //final because im never gonna change it once i have created it also making it private so that other classes cannot mess with it.
  bool showSpinner = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/women.jpg"), fit: BoxFit.cover)
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.black54,
              leading: Icon(Icons.shopping_cart),
              title: Text('log in/ sign up', style: TextStyle(fontFamily: 'ZillaSlab', fontSize: 25),),
            ),
            body: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      child: Image.asset('images/Rucksack1.png'),
                      radius: 70,
                      backgroundColor: Colors.blueGrey[900],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 40),
                        padding: EdgeInsets.only(left: 20),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Username'),
                          style: const TextStyle(color: Colors.white, fontFamily: 'Readex'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                        padding: EdgeInsets.only(left: 20),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Password'),
                          obscureText: true,
                          style: const TextStyle(color: Colors.white, fontFamily: 'Readex'),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        setState((){
                          showSpinner = true;
                        });
                        try {
                          final user = await _auth.signInWithEmailAndPassword(email: nameController.text, password: passwordController.text);
                          if (user != Null) {
                            Navigator.pushNamed(context, HomeScreen.id);
                          }
                        } catch (e) {
                          print(e);
                        }
                        setState((){
                          showSpinner = false;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFFEFE7E2),
                        ),
                        child: Center(child: Text('Log In', style: TextStyle(color: Colors.black),)),

                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          var email = nameController.text;
                          var pass = passwordController.text;
                          //print(email + " " + pass);
                          if (email.contains('tkmce.ac.in')) {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: nameController.text,
                                    password: passwordController.text);
                            Navigator.pushNamed(context, EmailVerify.id);
                            print('new user created');
                          } else {
                            _showToast(context);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFEFE7E2),
                          ),
                          child: Center(child: Text('SignUp In', style: TextStyle(color: Colors.black),)),

                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
