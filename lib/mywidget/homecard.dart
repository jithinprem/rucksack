import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rucksack/mywidget/myiconbutton/myiconbutton.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/screens/afteropen/afteropen.dart';

class HomeItemTile extends StatelessWidget {
  var maintitle;
  var subtitle;
  var pic;
  var profpic;
  var price;
  var longdesc;
  var utili;
  var tags;
  var condition;
  var userid; //for  contact
  var imgs;
  var documentid;
  IconData ic;
  HomeItemTile(
      this.maintitle,
      this.subtitle,
      this.pic,
      this.profpic,
      this.price,
      this.ic,
      this.longdesc,
      this.utili,
      this.tags,
      this.condition,
      this.userid,
      this.imgs,
      this.documentid) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3, left: 13, right: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xff2a2a2a),
      ),
      width: double.infinity,
      child: Card(
        color: Color(0xff2a2a2a),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AfterOpen(this.maintitle, this.longdesc, this.tags,
                      this.condition, this.utili, this.userid, this.imgs, this.documentid),
                ));
          },
          onLongPress: () {
            FirebaseAuth _auth = FirebaseAuth.instance;
            String? u_id = _auth.currentUser?.uid;
            if (u_id == userid) {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(
                        child: Text(
                      'Do you wanna remove the product ?',
                      style: TextStyle(fontFamily: 'Google'),
                      textAlign: TextAlign.center,
                    )),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () async {
                          CollectionReference collectionReference = FirebaseFirestore.instance.collection("allitems");
                          collectionReference..doc(documentid).delete();
                          Navigator.pop(context);
                        }
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black54,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 70,
                  child: ListTile(
                    tileColor: Color(0xff2a2a2a),
                    //leading: Icon(ic, size: 45, color: Colors.black54,),
                    title: Text(
                      maintitle + '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Google',
                          fontSize: 17,
                          color: Colors.white54),
                    ),
                    subtitle: Text(
                      subtitle,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          color: Colors.white),
                    ),
                    trailing: CircleAvatar(
                      backgroundImage: NetworkImage(profpic),
                      radius: 28,
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        child: Image.network(
                          pic,
                          fit: BoxFit.fill,
                          height: 220,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 80, right: 30),
                      height: 220,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Colors.black26,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          //simpleIconButton(FontAwesomeIcons.heart, Colors.white, Colors.transparent, (){print('hellohome');}, 17),
                          Text(
                            '\n   buy @   ',
                            style: TextStyle(
                                fontFamily: 'Google',
                                fontSize: 17,
                                color: Colors.white54),
                          ),
                          Text(
                            '\n ₹  ',
                            style: TextStyle(
                                fontFamily: 'Google',
                                fontSize: 25,
                                color: Colors.lime),
                          ),
                          Text(
                            price,
                            style: TextStyle(
                                fontFamily: 'Jatka',
                                fontSize: 45,
                                color: Colors.limeAccent,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
