import 'package:flutter/material.dart';
import 'package:rucksack/screens/logSignScreen.dart';

class RealLogin extends StatefulWidget {
  static String id = 'RealLogin';
  const RealLogin({Key? key}) : super(key: key);

  @override
  _RealLoginState createState() => _RealLoginState();
}

class _RealLoginState extends State<RealLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff2C3333),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10, left: 10, top: 40),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    height: 190,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/03/02/20/06/fishermans-cottage-1232942__340.jpg'),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6),
                            BlendMode.colorDodge),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Welcome,',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Readex',
                              fontSize: 20),
                        ),
                        Text(
                          'Log in to continue !',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Readex',
                              fontSize: 10,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'come find your beautiful home with us.....',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Readex',
                              fontSize: 10,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 150, left: 90),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/logo.jpg'),
                      radius: 89,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 40),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Username'),
                  style: TextStyle(color: Colors.black, fontFamily: 'Readex'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 20),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Password'),
                  style: TextStyle(color: Colors.black, fontFamily: 'Readex'),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 45, right: 45, top: 30),
                // padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFEFE7E2),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, LogSignScreen.id);
                  },
                  child: Text('Login', style: TextStyle(fontFamily: 'Readex', fontSize: 20, color: Colors.black87),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
