import 'package:flutter/material.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/screens/profilescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'homescreen';
  HomeScreen() {}

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _firestore = FirebaseFirestore.instance;
  // List details_item = [];
  // var x;
  //
  // Future getData(details_item) async{
  //   final items = await _firestore.collection('allitems').limit(2).get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       var details = {'it_description': doc['description'],'it_id': doc['id'], 'it_name': doc['name'], 'it_price': doc['price'], 'it_tags': doc['tags']};
  //       details_item.add(details);
  //       //print(details);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Rucksack'),
            leading: Icon(Icons.menu_rounded),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Profile.id);
                },
              )
            ]),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                    padding: EdgeInsets.all(20),
                    children: RetList().makedata()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RetList {
  List details_item = [];
  var details;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List> getData() async {
    final items = await _firestore
        .collection('allitems')
        .limit(5)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        details = {
          'it_description': doc['description'],
          'it_id': doc['id'],
          'it_name': doc['name'],
          'it_price': doc['price'],
          'it_tags': doc['tags']
        };
        details_item.add(details);
      });
    });
    return details_item;
  }

  List<Widget> makedata() {
    List<Widget> list = [];
    getData();
    for (int i = 0; i < details_item.length; i++) {
      var p = details_item.length;
      print('the length is the : $p');
      list.add(
        HomeItemTile(details_item[i]['it_name'], '1992 spring model', '', '',
            'model12A% 1992 watch for saale', Icons.watch),
      ); //add any Widget in place of Text("Index $i")
    }
    return list; // all widget added now retrun the list here
  }
}
