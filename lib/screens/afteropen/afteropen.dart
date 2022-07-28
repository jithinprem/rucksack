import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/mywidget/myiconbutton/myiconbutton.dart';
import 'package:rucksack/screens/homescreen.dart';
import 'package:rucksack/screens/profile/saleslist.dart';
import 'package:url_launcher/url_launcher.dart';

var todelstr =
    'While it may not be obvious to everyone, there are a number of reasons creating random paragraphs can be useful.'
    ' A few examples of how some people use this generator are listed in the ing paragraphs.';

class AfterOpen extends StatefulWidget {
  var out_tags;
  var out_longdesc;
  var out_util;
  var out_condition;
  var out_userid;
  var item_name;
  String out_documentid;
  List<String> out_imgs = [];

  //const AfterOpen({Key? key}) : super(key: key);
  // {
  //   /*{this.selectedItem}*/
  //   // print('\n\n\n this is what we are doing\n\n\n');
  //   // print(this.selectedItem);
  //   // allimgs = selectedItem!['item_image'];
  // }
  AfterOpen(this.item_name, this.out_longdesc, this.out_tags,
      this.out_condition, this.out_util, this.out_userid, this.out_imgs, this.out_documentid) {}
  static String id = 'afterOpen';

  @override
  State<AfterOpen> createState() => _AfterOpenState();
}

class _AfterOpenState extends State<AfterOpen> {

  void initState(){
    getPhoneNumber(widget.out_userid);
  }

  String myphoneNo = 'xxxxxxxxx';

  _launchPhoneURL(String phoneNumber) async {
    String number = phoneNumber;
    if (await canLaunchUrl(
        Uri(scheme: 'tel', path: number))) {
      await launchUrl(
          Uri(scheme: 'tel', path: number));
    } else {
      throw 'Could not launch $number';
    }
  }

  getPhoneNumber(String my_uid) async {
    var searchresult = [];
    final result = await FirebaseFirestore.instance
        .collection('profile')
        .where(
      'uid',
      isEqualTo: my_uid,
    ).get();
    searchresult = result.docs.map((e) => e.data()).toList();
    setState(() {
      myphoneNo = searchresult[0]['contact'].toString();
    });
  }

  addWishlist(){
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String? currUsername = _auth.currentUser?.email.toString();
    print(currUsername);
    _firestore.collection("profile").doc(currUsername).update(
      {
        'witem' : FieldValue.arrayUnion([widget.out_documentid])
      }
    ).then((_) => print('hellomywish'));
    // where(
    //   'uid',
    //   isEqualTo: _auth.currentUser?.uid.toString(),
    // ).add();

  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        print("the back button was pressed");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => HomeScreen())
        // );
        Navigator.pop(context);
        return true;
      },
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xff2a2a2a)),
        home: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.lime,
            title: const Text(
              'RuckSack',
              style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 20,
                  letterSpacing: 2.0,
                  color: Colors.white54),
            ),
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen())
                );
              },
            ),
          ),
          body: Column(
            children: [
              Stack(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 300.0,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        aspectRatio: 23 / 9),
                    items: widget.out_imgs.map((i) {
                      print("\nwidget is here rio" + i + "\n");
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width + 80,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: NetworkImage(i.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: Colors.black54,
                        //color: Colors.white,
                      ),
                      margin: EdgeInsets.only(top: 190),
                      height: 600 - 134,
                      width: double.infinity,
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                ),
                                child: Text(
                                  widget.item_name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Google',
                                    //backgroundColor: Colors.black54,
                                    letterSpacing: 1.8,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                simpleIconButton(FontAwesomeIcons.solidHeart,
                                    Colors.black, Color(0xfff1dfde), () {
                                  addWishlist();
                                  print('this is the first name');
                                }, 17),
                                simpleIconButton(FontAwesomeIcons.phone,
                                    Colors.black, Color(0xffe6dff1), () {

                                    _launchPhoneURL(myphoneNo);
                                }, 17),
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 18, top: 12, bottom: 8),
                                child: const Text(
                                  '🍃 Overview',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white54,
                                      letterSpacing: 1.3),
                                )),
                            Container(
                              height: MediaQuery.of(context).size.height - 481,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                //myitemselected['description'].toString()
                                children: <Widget>[
                                  RowTile(
                                      FontAwesomeIcons.database,
                                      'DETAILED DESCRIPTION\n\n' +
                                          widget.out_longdesc),
                                  RowTile(FontAwesomeIcons.timeline,
                                      'UTILITY\n\n' + widget.out_util),
                                  RowTile(
                                      FontAwesomeIcons.clock,
                                      'USAGE/ CONDITION\n\n' +
                                          widget.out_condition),
                                  RowTile(FontAwesomeIcons.tags,
                                      'TAGS\n\n' + widget.out_tags),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class RowTile extends StatelessWidget {
  var reficon;
  var txt;
  RowTile(this.reficon, this.txt) {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30, left: 16),
          child: CircleAvatar(
            child: Icon(
              reficon,
              size: 20,
              color: Colors.white54,
            ),
            radius: 30,
            backgroundColor: Color(0xff395B64),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 13, top: 20),
          width: MediaQuery.of(context).size.width - 110,
          child: Text(
            txt,
            style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w200),
          ),
        ),
      ],
    );
  }
}
