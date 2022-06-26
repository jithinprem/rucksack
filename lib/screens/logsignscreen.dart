import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.shopping_cart),
            title: Text('Welcome   Login/SignUp'),
          ),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Admission No.',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'password',
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
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
                    child: Text('Login'),
                  ),
                  ElevatedButton(
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
                      child: Text('signUp')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
