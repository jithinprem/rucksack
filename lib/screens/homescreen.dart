import 'package:flutter/material.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/screens/profilescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'homescreen';
  // RetList r1 = new RetList();
  HomeScreen(){
    getCall();
  }
  getCall() async{
    await RetList().makedata();
  }


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

  List details_item = [];

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
                    children: RetList.mylist),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RetList {


  List det_item = [];
  var details;
  static List<Widget> mylist = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List> getData() async {
    print('hello');
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
        this.det_item.add(details);
      });
    });
    print('det first');
    print(this.det_item);
    return this.det_item;
  }



  Future<List<Widget>> makedata() async{

    List<Widget> list = [];
    this.det_item = [];
    await getData();
    print('this is where we req');
    print(this.det_item);
    for (int i = 0; i < this.det_item.length; i++) {
      //var p = details_item.length;
      //print('the length is the : $p');
      mylist = [];
      mylist.add(
        HomeItemTile(this.det_item[i]['it_name'], '1992 spring model', '', '',
            'model12A% 1991 watch for sale', Icons.watch),
      ); //add any Widget in place of Text("Index $i")
    }
    //print(list);
    return mylist; // all widget added now retrun the list here
  }
}
