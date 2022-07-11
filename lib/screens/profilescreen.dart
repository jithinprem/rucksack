import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  void initState(){
    super.initState();
    getData();
  }

  final _auth = FirebaseAuth.instance;   // i guess its to retrieve the user who is logged in user
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var Gotname = 'Loading..';
  var GotBranch = 'Loading..';
  var GotYear = 'Loading..';
  var unloadedpic = 'https://img.freepik.com/free-photo/blur-hospital-clinic-interior_74190-5203.jpg?w=2000'; //denote the profile pic before loading

  printhello(){
    print('hello');
    getData();
  }

  // here we are trying to get data, since our collection has documents and these documents are not named properly
  // we should get all documents and then search within to get our data
  // this should be preferably modified later, try giving the document some name or something better

  // TODO : update the normally given uid to uid of the current user

  getData() async {
    var searchresult = [];
    final result = await FirebaseFirestore.instance.collection('profile')
        .where('uid', isEqualTo: 'xC2qWVuQMlQdSQ1whg5ynZfJqf52',)
        .get();
    searchresult = result.docs.map((e) => e.data()).toList();
    setState((){
      Gotname = searchresult[0]['name'];
      GotBranch = searchresult[0]['branch'];
      GotYear = searchresult[0]['year'];
      unloadedpic = searchresult[0]['profilepic'];
    });

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Profile', style: TextStyle(color: Colors.white),), backgroundColor: Colors.orange, leading: Icon(Icons.manage_accounts),),
        body: Column(
          children: <Widget>[
           Row(
             children: <Widget>[
               Container(
                 margin: EdgeInsets.all(20.0),
                 child: CircleAvatar(
                   backgroundImage: NetworkImage(unloadedpic),
                   radius: 60,
                 ),
               ),
               Container(
                 child: Column(
                   children: <Widget>[
                     Text(Gotname, style: TextStyle(color: Colors.orange, fontSize: 28),),
                     Text(GotBranch+' department'),
                     Text(GotYear +'rd year', style: TextStyle(fontSize: 20),)
                   ],
                 ),
               )
             ],
           ),
            ProfilePagetile('Update details',
                'the products in your sellcart', Icons.person, (){Navigator.pushNamed(context, UpdateDetail.id);}),
            ProfilePagetile('MY SALES LIST',
                'the products in your sellcart', Icons.sell, (){Navigator.pushNamed(context, SalesList.id);}),
            ProfilePagetile('MY ORDERS',
                'the products in your sellcart', Icons.shopping_cart, (){Navigator.pushNamed(context, MyOrder.id);}),
            ProfilePagetile('WISHLIST',
                'the products in your sellcart', Icons.heart_broken, printhello),
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
                ElevatedButton(onPressed: (){
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
