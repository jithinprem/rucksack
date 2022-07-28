import 'package:flutter/material.dart';
import 'package:rucksack/screens/logSignScreen.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/screens/logsecond.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/knot.gif'), fit: BoxFit.cover)),
        child: Scaffold(
          //backgroundColor: Colors.lightBlueAccent,
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: 60, bottom: 60, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: CircleAvatar(
                              child: Image.asset('images/ourlogo.gif'),
                              radius: 50,
                              backgroundColor: Colors.blueGrey[900],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'R U C K S A C K',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Google',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Hey there,\n\n\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Google',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\nWelcome\n to RuckSack!',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Google',
                          fontSize: 23),
                    ),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: 220,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Log in/Sign up to continue',
                            style: TextStyle(
                                color: Colors.black45,
                                fontFamily: 'Google',
                                fontSize: 20),
                          ),
                        ),
                        // space for
                        ListTile(
                          leading: Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: Icon(
                              Icons.verified_rounded,
                              color: Colors.lime,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'explore new products',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 10),
                          ),
                          subtitle: Text(
                            'trusted verified sellers',
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          ),
                          trailing: Icon(
                            Icons.verified_user_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        ListTile(
                          leading: Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: Icon(
                              Icons.verified_rounded,
                              color: Colors.lime,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'easy buy at great price',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 10),
                          ),
                          subtitle: Text(
                            'easy and effortlessly',
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          ),
                          trailing: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildButton(
                      margin: EdgeInsets.only(top: 170),
                      text: 'Login',
                      context: this.context,
                      id: LogSignScreen.id),
                  buildButton(
                      margin: EdgeInsets.only(top: 240),
                      text: 'SignUp',
                      context: this.context,
                      id: LogSignScreen.id),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildButton({
  required margin,
  required text,
  required context,
  required id,
}) =>
    Container(
      child: Container(
        margin: margin,
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Color(0xFFEFE7E2),
          onPressed: () => Navigator.pushNamed(context, id),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.grey[700],
              fontFamily: 'Readex',
            ),
          ),
        ),
      ),
    );
