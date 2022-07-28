import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/screens/additem.dart';

import '../../mywidget/homecard.dart';
import '../homescreen.dart';


class WishList extends StatefulWidget {
  static String id = 'wishlist';
  String? wishlistemail;
  WishList(){
    FirebaseAuth _auth = FirebaseAuth.instance;
     wishlistemail = _auth.currentUser?.email.toString();
  }

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  callfunc()async{
    await getWishlistItems();
  }

  @override
  void initState() {
    // TODO: implement initState
    callfunc();
    super.initState();
  }

  var wishlistitems = [];
  getWishlistItems() async{
      FirebaseFirestore _firebase = FirebaseFirestore.instance;
      var result = await _firebase.collection('profile').doc(widget.wishlistemail).get();
      setState((){
        wishlistitems = result.data()!['witem'] as List;
      });
      print(wishlistitems);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff2a2a2a),
          appBar: AppBar(
            shadowColor: Colors.lime,
            title: const Text(
              'RuckSack',
              style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 20,
                  letterSpacing: 2.0,
                  color: Colors.white54
              ),
            ),
            backgroundColor: Colors.black87,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            child: ListView(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('allitems')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      List itemlistreq = [];
                      itemlistreq =
                          snapshot.data!.docs.map((e) => {if(wishlistitems.contains(e.id))e.data()}).toList();
                      print('beginning');
                      List<Widget> widgetlist = [];

                      itemlistreq[0].forEach((val) => {
                                widgetlist.add(
                                  HomeItemTile(
                                    val['name'].toString(),
                                    val['shortdesc'].toString(),
                                    val['item_image'][0].toString(),
                                    val['profile_pic'].toString(),
                                    val['price'].toString(),
                                    Icons.watch,
                                    val['description'].toString(),
                                    val['utilities'].toString(),
                                    val['tags'].toString(),
                                    val['condition'].toString(),
                                    val['userid'].toString(),
                                    val['item_images'].toString(),
                                    'this is dummy string.. you should pass document id',
                                  ),
                                )
                              // }
                      });
                      //     String user_id = itemlistreq[i]['userid'].toString();
                      print("itemlisteq");
                      print("length is "+ widgetlist.length.toString());
                      return Column(
                        children: widgetlist,
                      );
                    }
                    return Text('nothing exist');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
