import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rucksack/screens/homescreen.dart';
import 'package:url_launcher/url_launcher.dart';

Color iccol = Colors.black87;
bool click = false;
FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
String? currUsername = _auth.currentUser?.email.toString();

class AfterOpen extends StatefulWidget {
  var out_tags;
  var out_longdesc;
  var out_util;
  var out_condition;
  var out_userid;
  var item_name;
  String out_documentid;
  List<String> out_imgs = [];

  AfterOpen(this.item_name, this.out_longdesc, this.out_tags,
      this.out_condition, this.out_util, this.out_userid, this.out_imgs, this.out_documentid) {
  }
  static String id = 'afterOpen';

  @override
  State<AfterOpen> createState() => _AfterOpenState();
}

class _AfterOpenState extends State<AfterOpen> {

  String myphoneNo = 'xxxxxxxxx';

  callgetCurrWish() async{
    await getCurrentWishStatus();
  }


 // retrive phone number
  void initState(){
    print('this start');
    callgetCurrWish();
    print('this ends');
    getPhoneNumber(widget.out_userid);
    super.initState();
  }

  // for phone number dial pad
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
    _firestore.collection("profile").doc(currUsername).update(
      {
        'witem' : FieldValue.arrayUnion([widget.out_documentid])
      }
    ).then((_) => print('hellomywish'));

  }
  removeWishlist(){
    _firestore.collection("profile").doc(currUsername).update(
        {
          'witem' : FieldValue.arrayRemove([widget.out_documentid])
        }
    ).then((_) => print('hellomywish'));
  }

  getCurrentWishStatus() async{
    var snapshot =  await _firestore.collection("profile").doc(currUsername).get();
    var itemList = await snapshot.data()!['witem'] as List;
    print(snapshot);
    if(itemList.contains(widget.out_documentid)){
      setState((){
        click = true;
        iccol = Colors.red;
        print("check color");
      });
    }else{
      setState((){
        click = false;
        iccol = Colors.black87;
        print("check color false");
      });
    }
  }


  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xff2a2a2a)),
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
              icon: const Icon(Icons.arrow_back),
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
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width + 80,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
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
                      ),
                      margin: const EdgeInsets.only(top: 190),
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
                                    iccol, const Color(0xfff1dfde), () {
                                  click = click==true ? false : true;
                                  if(click){
                                    setState((){
                                      addWishlist();
                                      iccol = Colors.red;
                                      print("state changed $iccol");

                                    });
                                  }else{
                                    setState((){
                                      removeWishlist();
                                      iccol = Colors.black87;
                                      print("state changed $iccol");

                                    });
                                  }

                                  print('this is the first name');
                                }, 17),
                                simpleIconButton(FontAwesomeIcons.phone,
                                    Colors.black, const Color(0xffe6dff1), () {

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
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 481,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
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


class simpleIconButton extends StatelessWidget {
  var iconColor;
  var boxColor;
  var onpressedfunc;
  var boxicon;
  var size;
  simpleIconButton(this.boxicon, this.iconColor, this.boxColor, this.onpressedfunc, this.size){
    this.size = this.size*1.0;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Container(
          height: 85,
          width: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: boxColor,
          ),
          child: boxicon == FontAwesomeIcons.solidHeart ? Icon(boxicon, color: iccol, size: size,):  Icon(boxicon, color: Colors.black87, size: size,)
        ),
        onPressed: onpressedfunc
    );
  }
}
