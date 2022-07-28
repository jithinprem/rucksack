import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/screens/profilescreen.dart';

import '../mywidget/homecard.dart';
import 'homescreen.dart';

class Trending extends StatefulWidget {
  static String id = 'trending';
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
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
              flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54,
                  ),
                  height: 35,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/redfire2.gif'),
                          radius: 30,
                          backgroundColor: Colors.lime,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('      Trending Now', style: TextStyle(fontFamily: 'Google', fontSize: 22),),
                          Text('    go grap them quick', style: TextStyle(fontSize: 14, fontFamily: 'Allura', color: Colors.white70),)
                        ],
                      ),
                    ],
                  ),
                ),
            ),
            Expanded(
              flex: 8,
              child: ListView(padding: EdgeInsets.all(0),
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('allitems').orderBy('wishcount', descending: true)
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
