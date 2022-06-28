import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rucksack/screens/profilescreen.dart';
import 'dart:io';



class AddItem extends StatefulWidget {
  static String id = 'additem';

  AddItem();


  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  _AddItemState(){
    print('hai');
    getUser(useremailid);
  }

  File _image;

  void getImage() async{

  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var useremailid = 'whatever';

  Future getUser(useremail) async {
    User currUser;
    final _auth = FirebaseAuth.instance;
    currUser =  await _auth.currentUser!;
    useremail = currUser.email!;
    print(useremailid);
    return currUser;

  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  void UploadItem() async{
      var itemname = nameController.text;
      var descitem = descController.text;
      var priceitem = priceController.text;
      var tags = tagsController.text;

      if(itemname != Null && descitem != Null && priceitem != Null) {
        print('uploading is being performed......................');
        await _firestore.collection('allitems').add({
          'description': descitem,
          'id': useremailid,
          'name': itemname,
          'price': priceitem,
          'tags': tags,
        });
        Navigator.pushNamed(context, Profile.id);
      }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(useremailid),
                  tileColor: Colors.black54,
                ),
                TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Item  Name',
                    border: OutlineInputBorder(),
                  ),

                ),
                TextField(
                  minLines: 3,
                  maxLines: 5,
                  controller: descController,
                  decoration: InputDecoration(
                    hintText: 'description',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    hintText: 'price',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  minLines: 3,
                  maxLines: 5,
                  controller: tagsController,
                  decoration: InputDecoration(
                    hintText: 'tags',
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: (){UploadItem();}, child: Text('Photo'),),
                    ElevatedButton(onPressed: (){UploadItem();}, child: Text('Add'),),
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

