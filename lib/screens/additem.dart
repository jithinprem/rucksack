
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rucksack/color/colors.dart';
import 'package:rucksack/screens/profilescreen.dart';
//import 'package:rucksack/functions/upImage.dart';

var useremail = 'uye';

class AddItem extends StatefulWidget {
  static String id = 'additem';

  AddItem();

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  _AddItemState() {
    getUser();
    getProfilepic();
    getUsername();
  }

  final storageRef = FirebaseStorage.instance.ref();
  XFile? image = XFile('');
  var imgWidget1 = NetworkImage(
      'https://www.dreamstime.com/no-image-available-icon-photo-camera-flat-vector-illustration-image132483141');
  var imgWidget2 = NetworkImage(
      'https://www.dreamstime.com/no-image-available-icon-photo-camera-flat-vector-illustration-image132483141');
  var imgWidget3 = NetworkImage(
      'https://www.dreamstime.com/no-image-available-icon-photo-camera-flat-vector-illustration-image132483141');

  User? currUser;
  String dfileUrl = '';
  List<String> dfiles = [];
  String? profilePicUrl;
  String userName = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? valuex = "Unboxed";

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController utilController = TextEditingController();
  TextEditingController shortdescController = TextEditingController();



  getProfilepic() async {
    var searchresult = [];
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? currUser = _auth.currentUser;
    var uid = currUser!.uid;

    var result = await FirebaseFirestore.instance
        .collection('profile')
        .where(
      'uid',
      isEqualTo: uid,
    )
        .get();

    searchresult = await result.docs.map((e) => e.data()).toList();
    setState(() {
      profilePicUrl = searchresult[0]['profilepic'];
    });
    return searchresult[0]['profilepic'];
  }

  getUsername() async {
    var searchresult = [];
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? currUser = _auth.currentUser;
    var uid = currUser!.uid;

    var result = await FirebaseFirestore.instance
        .collection('profile')
        .where(
      'uid',
      isEqualTo: uid,
    )
        .get();

    searchresult = await result.docs.map((e) => e.data()).toList();
    setState(() {
      userName = searchresult[0]['name'];
    });
    return searchresult[0]['name'];
  }

  select() async {

    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    // ImagePicker imagePicker = ImagePicker();
    // image = await imagePicker.pickImage(
    //   source: ImageSource.camera,
    //   imageQuality: 35,
    // );
  }

  upload(val) async {
    final mountainsRef =
    storageRef.child('/$val/' + DateTime.now().toString() + '.jpg');
    File myFile = File(image!.path);
    try {
      await mountainsRef.putFile(myFile);
    } catch (e) {
      print(e);
    }
    dfileUrl = await mountainsRef.getDownloadURL();
    dfiles.add(dfileUrl);
    setState(() {
      dfiles;
    });
    print('the dfiles array is -');
    print(dfiles);
  }

  Future getUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    currUser = await _auth.currentUser!;
    useremail = currUser!.email!;
    print(useremail);
    setState(() {
      useremail;
    });
    return currUser;
  }

  void selectAndUpload(val, index) async {
    await select();
    print('select is complete');
    await upload(val);
    print('upload is complete');
    updateIconstoImg(dfiles[index-1], index);
    sleep(const Duration(seconds: 5));
  }

  updateIconstoImg(url, index) {
    setState(() {
      if(index == 1)
        imgWidget1 = NetworkImage(url);
      else if(index == 2)
        imgWidget2 = NetworkImage(url);
      else if(index == 3)
        imgWidget3 = NetworkImage(url);
    });
  }

  void UploadItem() async {
    var itemname = nameController.text;
    var descitem = descController.text;
    var priceitem = priceController.text;
    var tags = tagsController.text;
    var utilDesc = utilController.text;
    var shortdesc = shortdescController.text;

    profilePicUrl = await getProfilepic();

    if (itemname != Null && descitem != Null && priceitem != Null) {
      print('uploading is being performed......................');
      await _firestore.collection('allitems').add({
        'description': descitem,
        'id': useremail,
        'name': itemname,
        'shortdesc' : shortdesc,
        'price': priceitem,
        'tags': tags,
        'utilities' : utilDesc,
        'condition' : valuex,
        'userid': currUser!.uid,
        'item_image': dfiles,
        'profile_pic': profilePicUrl,
      });
      Navigator.pop(context);
    }
  }

  var _isStarted = false;
  var _isLoading = false;
  var boolval = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ModalProgressHUD(
            inAsyncCall: boolval,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.faceSmileWink, color: Color(0xffFF869E), size: 30,),
                    title: Text('Hi, ' + userName, style: TextStyle(fontSize: 20, color: Colors.black54, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),),
                    subtitle: Text('        we are happy to recieve your item', style: TextStyle(color: Colors.black, fontFamily: 'ZillaSlab'),),
                    tileColor: Color(0xFFEFE7E2),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Expanded(
                    flex: 4,
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            TextF(
                                nameController: nameController,
                                stri: 'Item Name',
                                minlin: 1,
                                maxlin: 5),
                            TextF(
                                nameController: shortdescController,
                                stri: 'Short Description',
                                minlin: 1,
                                maxlin: 1000
                            ),
                            TextF(
                                nameController: descController,
                                stri: 'Description',
                                minlin: 3,
                                maxlin: 5),
                            TextF(
                                nameController: utilController,
                                stri: 'Utilities',
                                minlin: 1,
                                maxlin: 1000
                            ),

                            // TODO: some design issues occured, so neglected
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white54
                                ),
                              ),

                              child: DropdownButton<String>(
                                value: valuex,
                                style: TextStyle(color: Colors.white54),

                                items: <String>[
                                  'Unboxed',
                                  'Superb',
                                  'Very Good',
                                  'Ok',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value1) {
                                  setState(() {
                                    valuex = value1;
                                  });
                                },
                              ),
                            ),
                            TextF(
                                nameController: priceController,
                                stri: 'Price',
                                minlin: 1,
                                maxlin: 5),
                            TextF(
                                nameController: tagsController,
                                stri: 'Tags in',
                                minlin: 1,
                                maxlin: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //color: bcol,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: imgWidget1, fit: BoxFit.cover)
                              ),
                              child:  _isStarted
                          ? (_isLoading ? const CircularProgressIndicator(color: Colors.red, strokeWidth: 2.5,):null)
                            : const Icon(Icons.add),
                            ),
                            onPressed: () {
                              //upload the image
                              setState((){
                                _isStarted = true;
                                _isLoading = true;
                              });
                              selectAndUpload('items', 1);
                              setState((){
                                _isLoading = false;
                              });

                            },
                          ),
                          TextButton(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: imgWidget2, fit: BoxFit.cover)
                              ),
                              child: Icon(Icons.add),
                            ),
                            onPressed: () {
                              //upload the image
                              selectAndUpload('items', 2);
                            },
                          ),
                          TextButton(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: imgWidget3, fit: BoxFit.cover)
                              ),
                              child: Icon(Icons.add),
                            ),
                            onPressed: () {
                              //upload the image
                              selectAndUpload('items', 3);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //ElevatedButton(onPressed: (){selectAndUpload('items');}, child: Text('Photo'),),
                        ElevatedButton(
                          onPressed: () {
                            getProfilepic();
                          },
                          child: Text('Photo'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            UploadItem();
                          },
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextF extends StatelessWidget {
  TextF({
    Key? key,
    required this.nameController,
    this.stri = '',
    this.minlin,
    this.maxlin,
  }) : super(key: key);

  final TextEditingController nameController;
  String stri;
  var minlin, maxlin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: TextField(
        minLines: minlin,
        maxLines: maxlin,
        controller: nameController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          hintText: stri,
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
