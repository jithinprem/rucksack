import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/mywidget/homecard.dart';
import 'package:rucksack/screens/profilescreen.dart';

// getCall() async{
//   await Future.delayed(const Duration(seconds: 4), (){});
//   await RetList().makedata();
// }

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
    //getCall();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                                  child: const Padding(
                                    padding: EdgeInsets.only(
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
                                    Navigator.pushNamed(context, Profile.id)
                                        .then(onGoBack);
                                  }),
                                  circlenode(Icons.location_on, () {
                                    print('additem');
                                  }),
                                  circlenode(Icons.search, () {
                                    print('additem');
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SearchPage()));
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('allitems')
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

                              List<Widget> widgetlist = [];
                              for (int i = 0; i < itemlistreq.length; i++) {
                                String it_name =
                                    itemlistreq[i]['name'].toString();
                                String it_desc =
                                    itemlistreq[i]['description'].toString();
                                String it_img =
                                    itemlistreq[i]['item_image'][0].toString();
                                String it_price =
                                    itemlistreq[i]['price'].toString();
                                String user_id =
                                    itemlistreq[i]['userid'].toString();
                                String circular_profileimg =
                                    itemlistreq[i]['profile_pic'].toString();

                                String imgid = getImgData(user_id).toString();
                                if (imgid.isNotEmpty) {
                                  print('we are done here');
                                  widgetlist.add(HomeItemTile(
                                      it_name,
                                      it_desc,
                                      it_img,
                                      circular_profileimg,
                                      it_price,
                                      Icons.watch,
                                      //itemlistreq[i],
                                  ));
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
                        var itemlistreq = [];
                        itemlistreq =
                            snapshot.data!.docs.map((e) => e.data()).toList();

                        List<Widget> widgetlist = [];
                        for (int i = 0; i < itemlistreq.length; i++) {
                          String it_name = itemlistreq[i]['name'].toString();
                          if (it_name.contains(val)) {
                            String it_desc =
                                itemlistreq[i]['description'].toString();
                            String it_img =
                                itemlistreq[i]['item_image'][0].toString();
                            String it_price =
                                itemlistreq[i]['price'].toString();
                            String user_id =
                                itemlistreq[i]['userid'].toString();
                            String circular_profileimg =
                                itemlistreq[i]['profile_pic'].toString();
                            print(user_id);
                            String imgid = getImgData(user_id).toString();
                            if (imgid.isNotEmpty) {
                              print('we are done here');
                              widgetlist.add(
                                HomeItemTile(it_name, it_desc, it_img,
                                    circular_profileimg, it_price, Icons.watch),
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
