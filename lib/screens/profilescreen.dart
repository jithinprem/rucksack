import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/screens/additem.dart';
import 'package:rucksack/screens/homescreen.dart';
import 'package:rucksack/screens/logSignScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  static String id = 'profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;


  printhello(){
    print('hello');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Hi, {username}'),),
        body: Column(
          children: <Widget>[
           
            Container(
              margin: EdgeInsets.all(20.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://images.generated.photos/BBr_6ubXwG-Ra3Euqy63cnTUvIUW5QqgAzV46jKBiAk/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/OTYxMDU5LmpwZw.jpg'),
                radius: 60,
              ),
            ),
            ProfilePagetile('Update details',
                'the products in your sellcart', Icons.person, printhello()),
            ProfilePagetile('MY SALES LIST',
                'the products in your sellcart', Icons.sell, printhello()),
            ProfilePagetile('MY ORDERS',
                'the products in your sellcart', Icons.shopping_cart, printhello()),
            ProfilePagetile('WISHLIST',
                'the products in your sellcart', Icons.monitor_heart, printhello()),
            ProfilePagetile('ADD ITEM',
                'start earning 💸', Icons.comment, (){Navigator.pushNamed(context, AddItem.id);}),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(onPressed: ()async{
                  await _auth.signOut();
                  Navigator.pushNamed(context, LogSignScreen.id);
                }
                  , child: Text('Log out'),
                ),
                ElevatedButton(onPressed: ()async{
                  Navigator.pushNamed(context, HomeScreen.id);
                }
                  , child: Text('Goback'),
                ),
              ],
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
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(ic),
        tileColor: Colors.white24,
        onTap: perfunc,
      ),
    );
  }
}
