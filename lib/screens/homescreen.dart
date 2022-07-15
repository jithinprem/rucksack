import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/screens/profilescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// getCall() async{
//   await Future.delayed(const Duration(seconds: 4), (){});
//   await RetList().makedata();
// }

getImgData(UserUid) async {
  var searchresult = [];
  final result = await FirebaseFirestore.instance.collection('profile')
      .where('uid', isEqualTo: UserUid,)
      .get();
  searchresult = await result.docs.map((e) => e.data()).toList();
  print(searchresult[0]['profilepic']);
  return await searchresult[0]['profilepic'];

}

class HomeScreen extends StatefulWidget {
  static String id = 'homescreen';
  HomeScreen(){
    //getCall();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List details_item = [];
  var changeint = 0;
  var profileImg = '';

  Future<String> setprofileImg(user_id) async{
    String profileImg= await getImgData(user_id).toString();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(changeint.toString()),
            leading: Icon(Icons.menu_rounded),
            backgroundColor: Color(0xff141E27),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
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
                child: ListView(
                    padding: EdgeInsets.all(15),
                    //children: RetList.mylist,
                    children: <Widget>[
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('allitems').snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if(snapshot.hasData){
                            var itemlistreq = [];
                            itemlistreq = snapshot.data!.docs.map((e) => e.data()).toList();

                            List<Widget> widgetlist = [];
                            for(int i=0; i<itemlistreq.length; i++){
                              String it_name = itemlistreq[i]['name'].toString();
                              String it_desc = itemlistreq[i]['description'].toString();
                              String it_img = itemlistreq[i]['item_image'][0].toString();
                              String it_price = itemlistreq[i]['price'].toString();
                              String user_id = itemlistreq[i]['userid'].toString();
                              String circular_profileimg = itemlistreq[i]['profile_pic'].toString();
                              print(user_id);
                              String imgid = getImgData(user_id).toString();
                              if(imgid.isNotEmpty){
                                print('we are done here');
                                widgetlist.add(HomeItemTile(it_name, it_desc, it_img, circular_profileimg, it_price, Icons.watch));
                              }
                            }
                            return Column(
                              children: widgetlist,
                            );
                          }
                          return Text('nothing exist');
                        },
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class RetList {
//
//
//   List det_item = [];
//   var details;
//   static List<Widget> mylist = [];
//
//
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Future<List> getData() async {
//
//     final items = await _firestore
//         .collection('allitems')
//         .limit(5)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         details = {
//           'it_description': doc['description'],
//           'it_id': doc['id'],
//           'it_name': doc['name'],
//           'it_price': doc['price'],
//           'it_tags': doc['tags'],
//           'it_userid' : doc['userid'],
//           'it_item_image' : doc['item_image'][0],
//         };
//         this.det_item.add(details);
//       });
//     });
//
//     return this.det_item;
//   }
//
//
//
//   Future<List<Widget>> makedata() async{
//
//     List<Widget> list = [];
//     var profileImg = await getImgData('xC2qWVuQMlQdSQ1whg5ynZfJqf52');
//     await getData();
//     mylist = [];
//     for (int i = 0; i < this.det_item.length; i++) {
//       mylist.add(
//         HomeItemTile(this.det_item[i]['it_name'], this.det_item[i]['it_description'], this.det_item[i]['it_item_image'], profileImg,
//             this.det_item[i]['it_price'], Icons.watch),
//       ); //add any Widget in place of Text("Index $i")
//     }
//     return mylist; // all widget added now retrun the list here
//   }
// }
