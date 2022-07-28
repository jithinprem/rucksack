import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/screens/additem.dart';
import 'package:rucksack/screens/homescreen.dart';
import 'package:rucksack/screens/logSignScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rucksack/screens/profile/broughtlist.dart';
import 'package:rucksack/screens/profile/saleslist.dart';
import 'package:rucksack/screens/profile/update.dart';


class Profile extends StatefulWidget {
  static String id = 'profile';
  // ignore: use_key_in_widget_constructors
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void initState() {
    super.initState();
    getData();
  }

  final _auth = FirebaseAuth
      .instance; // i guess its to retrieve the user who is logged in user
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var Gotname = 'Loading..';
  var GotBranch = 'Loading..';
  var GotYear = 'Loading..';
  var unloadedpic =
      'https://img.freepik.com/free-photo/blur-hospital-clinic-interior_74190-5203.jpg?w=2000'; //denote the profile pic before loading

  printhello() {
    print('hello');
    getData();
  }

  // here we are trying to get data, since our collection has documents and these documents are not named properly
  // we should get all documents and then search within to get our data
  // this should be preferably modified later, try giving the document some name or something better

  // TODO : update the normally given uid to uid of the current user

  getData() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var searchresult = [];
    final result = await FirebaseFirestore.instance
        .collection('profile')
        .where(
          'uid',
          isEqualTo: _auth.currentUser?.uid.toString(),
        )
        .get();
    searchresult = result.docs.map((e) => e.data()).toList();
    setState(() {
      Gotname = searchresult[0]['name'];
      GotBranch = searchresult[0]['branch'];
      GotYear = searchresult[0]['year'];
      unloadedpic = searchresult[0]['profilepic'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xff2a2a2a)),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffe8db90),
              ),
              padding: EdgeInsets.only(bottom: 20, top: 20),
              width: double.infinity,
              margin: EdgeInsets.only(top: 15, bottom: 10, left: 29, right: 29),
              child:  Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(unloadedpic),
                    radius: 60,
                  ),
                  Text(
                    Gotname,
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 40,
                        fontFamily: 'Google',
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    GotBranch + ' department',
                    style: const TextStyle(fontFamily: 'Google', fontSize: 18, color: Colors.black54),
                  ),
                  Text(
                    GotYear + 'rd year',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Google', color: Colors.black54),
                  ),
                  const Text(
                    'Discover the good things inside...',
                    style: TextStyle(fontSize: 10, fontFamily: 'HomemadeApple', color: Colors.black54, ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ProfilePagetile(
                'SALE LIST', 'check your products', Icons.sell,
                () {
              Navigator.pushNamed(context, SalesList.id);
            }),
            // ProfilePagetile('MY ORDERS', 'your purchases ',
            //     Icons.shopping_cart, () {
            //   Navigator.pushNamed(context, MyOrder.id);
            // }),
            ProfilePagetile('WISHLIST', 'check wishlisted products',
                Icons.heart_broken, (){print('macho');}),
            ProfilePagetile('ADD ITEM', 'start earning 💸', Icons.photo_size_select_large, () {
              Navigator.pushNamed(context, AddItem.id);
            }),
            ProfilePagetile('ABOUT US', 'developers', Icons.people, () {
              Navigator.pushNamed(context, AddItem.id);
            }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(context, LogSignScreen.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text('Log Out', style: TextStyle(color: Colors.black54, fontFamily: 'Google', fontWeight: FontWeight.bold),)),
                height: 50,
                width: 120,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xffe8db90))),
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePagetile extends StatelessWidget {
  var title, subtitle, ic, perfunc;
  ProfilePagetile(this.title, this.subtitle, this.ic, this.perfunc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 12, bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(30), left: Radius.circular(30)),
        ),
        tileColor: Colors.grey[800],
        title: Text(title, style: TextStyle(fontFamily: 'Google', letterSpacing: 1.3),),
        subtitle: Text(subtitle),
        leading: Icon(ic),
        onTap: perfunc,
      ),
    );
  }
}
