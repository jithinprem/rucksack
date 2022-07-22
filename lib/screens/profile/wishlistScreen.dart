import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/screens/profilescreen.dart';

// getCall() async{
//   await Future.delayed(const Duration(seconds: 4), (){});
//   await RetList().makedata();
// }
getUid() {
  return FirebaseAuth.instance.currentUser?.uid;
}

getWishListItems() {
  final userId = getUid();
  List<String> wishList = [];
  FirebaseFirestore.instance.collection('wishListItems').doc(userId).get().then(
      (DocumentSnapshot) =>
          {((DocumentSnapshot.data() as dynamic)['items']) as List});
  print("snapit $wishList");
  return wishList;
}

Future<List<Widget>> mapWishtoItems(snapshot) async {
  List itemlistreq = [];
  var itemlistreq1 = getWishListItems();
  print("Debug Point starts");
  print(itemlistreq1.length);
  print("Debug point ends");
  var documents = (await (snapshot).docs).toList();
  for (int i = 1; i < itemlistreq1.length; i++) {
    print("looper");
    int index = documents.indexOf(itemlistreq1[i]);
    if (index != -1) {
      itemlistreq.add(documents[i]);
    }
  }
  List<Widget> widgetlist = [];
  for (int i = 0; i < itemlistreq.length; i++) {
    print("looper");
    String it_name = itemlistreq[i]['name'].toString();
    String it_desc = itemlistreq[i]['description'].toString();
    String it_img = itemlistreq[i]['item_image'][0].toString();
    String it_price = itemlistreq[i]['price'].toString();
    String user_id = itemlistreq[i]['userid'].toString();
    String circular_profileimg = itemlistreq[i]['profile_pic'].toString();
    print(user_id);
    String imgid = getImgData(user_id).toString();
    if (imgid.isNotEmpty) {
      print('we are done here');
      widgetlist.add(HomeItemTile(it_name, it_desc, it_img, circular_profileimg,
          it_price, Icons.watch));
    }
  }
  return widgetlist;
}

getImgData(UserUid) async {
  var searchresult = [];
  final result = await FirebaseFirestore.instance
      .collection('profile')
      .where(
        'uid',
        isEqualTo: UserUid,
      )
      .get();
  searchresult = await result.docs.map((e) => e.data()).toList();
  print(searchresult[0]['profilepic']);
  return await searchresult[0]['profilepic'];
}

class WishListScreen extends StatefulWidget {
  static String id = 'WishListScreen';
  WishListScreen() {
    //getCall();
  }

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List details_item = [];
  var changeint = 0;
  var profileImg = '';

  Future<String> setprofileImg(user_id) async {
    String profileImg = await getImgData(user_id).toString();
    print('the profile image after setprofileImg is :');
    print(profileImg.toString());
    return profileImg;
  }

  void refreshData() {
    changeint++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black87),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'RuckSack',
                style: TextStyle(
                    fontFamily: 'PressStart',
                    fontSize: 14,
                    color: Colors.black54),
              ),
              leading: Icon(
                Icons.menu_rounded,
                color: Colors.black38,
              ),
              backgroundColor: bcol,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black38,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Profile.id).then(onGoBack);
                  },
                )
              ]),
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(padding: EdgeInsets.all(0),
                      //children: RetList.mylist,
                      children: <Widget>[
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1536562833330-a59dc2305a5c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHJ1Y2tzYWNrfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                                      colorFilter: ColorFilter.mode(
                                        Colors.black38.withOpacity(0.3),
                                        BlendMode.darken,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17, top: 15),
                                    child: Text(
                                      'RUCKSACK, \n       Good Things Inside...',
                                      style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          color: Colors.white),
                                    ),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  circlenode(Icons.add_a_photo_outlined, () {
                                    print('additem');
                                  }),
                                  circlenode(Icons.person, () {
                                    print('additem');
                                  }),
                                  circlenode(Icons.location_on, () {
                                    print('additem');
                                  }),
                                  circlenode(Icons.search, () {
                                    print('additem');
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ), // DocumentSnapshot<Map<String, dynamic>>

                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('allitems')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<Widget> widgetlist = [];
                              var widgetlistd = mapWishtoItems(snapshot.data);
                              widgetlistd.then((value) {
                                if (value != null)
                                  value.forEach((item) => widgetlist.add(item));
                              });
                              return Column(
                                children: widgetlist,
                              );
                            })

                        // return Text('nothing exist2');
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class circlenode extends StatelessWidget {
  var circleicon;
  var circlefunc;
  circlenode(this.circleicon, this.circlefunc) {}

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        margin: EdgeInsets.only(top: 110),
        child: CircleAvatar(
          child: Icon(
            circleicon,
            color: Colors.grey[800],
          ),
          radius: 30,
          backgroundColor: Color(0xFFEFE7E2),
        ),
      ),
      onPressed: circlefunc,
    );
  }
}
