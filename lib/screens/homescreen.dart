import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/screens/profilescreen.dart';

import 'additem.dart';

// get image when you give userid
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




class HomeScreen extends StatefulWidget {



  static String id = 'homescreen';
  HomeScreen() {

  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List details_item = [];
  var changeint = 0;
  var profileImg = '';

  void initState() {
    super.initState();
    getUserName();
  }

  Future<String> setprofileImg(user_id) async {
    String profileImg = await getImgData(user_id).toString();
    print('the profile image after setprofileImg is :');
    print(profileImg.toString());
    return profileImg;
  }

  String Helloname = 'Loading...';
  // get data
  getUserName() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var searchresult = [];
    final result = await FirebaseFirestore.instance.collection('profile')
        .where('uid', isEqualTo: _auth.currentUser?.uid.toString(),)
        .get();
    searchresult = result.docs.map((e) => e.data()).toList();
    setState((){
      Helloname = searchresult[0]['name'].toString();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white54,
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
                child: ListView(padding: EdgeInsets.all(0),
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Hello $Helloname', style: TextStyle(color: Colors.white54, fontFamily: 'Google', fontSize: 30),),
                                Text('welcome to rucksack',style: TextStyle(color: Colors.white54, fontFamily: 'Google', fontSize: 13),)
                              ],
                            ),
                          )
                      ),
                      Expanded(
                        child: Container(
                          height: 180,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              circlenode(Icons.add_a_photo_outlined, () {
                                print('additem');
                                Navigator.pushNamed(context, AddItem.id);
                              }, Color(0xffc0dedd), 'Add item'),
                              circlenode(Icons.person, () {
                                print('additem');
                                Navigator.pushNamed(context, Profile.id);
                              }, Color(0xffe6dff1), 'Profile'),
                              circlenode(Icons.local_fire_department_rounded, () {
                                print('additem');
                              }, Color(0xfff1dfde), 'Trending'),
                              circlenode(Icons.search, () {
                                print('additem');
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const SearchPage()));
                              }, Color(0xfff2eee9), 'Search'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('allitems').orderBy('time', descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            List itemlistreq = [];
                            itemlistreq = snapshot.data!.docs
                                .map((e) => e.data())
                                .toList();
                            List itemidreq = [];
                            itemidreq = snapshot.data!.docs
                                .map((e) => e.id)
                                .toList();
                            List<Widget> widgetlist = [];
                            for (int i = 0; i < itemlistreq.length; i++) {
                              String documentid = itemidreq[i].toString();
                              String it_name =
                                  itemlistreq[i]['name'].toString();

                              String it_desc =
                                  itemlistreq[i]['shortdesc'].toString();
                              List<String> items_images = [];
                              for(String x in itemlistreq[i]['item_image']){
                                items_images.add(x.toString());
                              }
                              String it_price =
                                  itemlistreq[i]['price'].toString();
                              String user_id =
                                  itemlistreq[i]['userid'].toString();
                              String circular_profileimg =
                                  itemlistreq[i]['profile_pic'].toString();
                              print(user_id);
                              String imgid = getImgData(user_id).toString();
                              String longdesc =
                                  itemlistreq[i]['description'].toString();
                              String utili =
                                  itemlistreq[i]['utilities'].toString();
                              String tags = itemlistreq[i]['tags'].toString();
                              String condition = itemlistreq[i]['condition'];
                              if (imgid.isNotEmpty) {
                                print('we are done here');
                                widgetlist.add(
                                  HomeItemTile(
                                      it_name,
                                      it_desc,
                                      items_images[0],
                                      circular_profileimg,
                                      it_price,
                                      Icons.watch,
                                      longdesc,
                                      utili,
                                      tags,
                                      condition,
                                      user_id,
                                      items_images,
                                      documentid,
                                      ),
                                );
                              }
                            }
                            return Column(
                              children: widgetlist,
                            );
                          }

                          return Text('nothing exist');
                        },
                      ),
                    ]),
              ),
            ],
          ),
        ),
      );

  }
}

class circlenode extends StatelessWidget {
  var circleicon;
  var circlefunc;
  var col;
  var title;
  circlenode(this.circleicon, this.circlefunc, this.col, this.title) {}

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: circlefunc,
      child: Container(
        decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.circular(30),
        ),
        height: 140,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(circleicon, color: Colors.black54, size: 32,),
            SizedBox(
              height: 20,
            ),
            Center(
              child:Text(title, style: TextStyle(fontFamily: 'Google', fontSize: 14, letterSpacing: 1.1, color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}


// Search Page
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final myController = TextEditingController();
  var val = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2a2a2a),
      appBar: AppBar(
          // The search area here
          automaticallyImplyLeading: false,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: TextField(
                        onSubmitted: (value) {
                          print('we are sumbitting');
                          setState(() {
                            val = value;
                          });
                        },
                        autofocus: true,
                        controller: myController,
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                val = myController.text;
                              });
                            },
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              /* Clear the search field */
                              myController.text = "";
                            },
                          ),
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView(padding: EdgeInsets.all(0),
                //children: RetList.mylist,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
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
                            snapshot.data!.docs.map((e) => e.data()).toList();
                        List itemidreq = [];
                        itemidreq = snapshot.data!.docs
                            .map((e) => e.id)
                            .toList();

                        List<Widget> widgetlist = [];
                        for (int i = 0; i < itemlistreq.length; i++) {

                          String documentid = itemidreq[i].toString();
                          String it_name = itemlistreq[i]['name'].toString();
                          if (it_name.contains(val)) {
                            String it_desc =
                                itemlistreq[i]['shortdesc'].toString();
                            int k=0;
                            List<String> items_images = [];

                            for(String x in itemlistreq[i]['item_image']){
                              items_images.add(x.toString());
                            }
                            String it_price =
                            itemlistreq[i]['price'].toString();
                            String user_id =
                            itemlistreq[i]['userid'].toString();
                            String circular_profileimg =
                            itemlistreq[i]['profile_pic'].toString();
                            print(user_id);
                            String imgid = getImgData(user_id).toString();
                            String longdesc =
                            itemlistreq[i]['description'].toString();
                            String utili =
                            itemlistreq[i]['utilities'].toString();
                            String tags = itemlistreq[i]['tags'].toString();
                            String condition = itemlistreq[i]['condition'];
                            if (imgid.isNotEmpty) {
                              print('we are done here');
                              widgetlist.add(
                                HomeItemTile(
                                  it_name,
                                  it_desc,
                                  items_images[0],
                                  circular_profileimg,
                                  it_price,
                                  Icons.watch,
                                  longdesc,
                                  utili,
                                  tags,
                                  condition,
                                  user_id,
                                  items_images,
                                  documentid,
                                ),
                              );
                            }
                          }
                        }
                        return Column(
                          children: widgetlist,
                        );
                      }
                      return Text('nothing exist');
                    },
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
