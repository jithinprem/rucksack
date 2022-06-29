import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rucksack/screens/profilescreen.dart';
import 'dart:io';
import 'imageupload/imgupload.dart';

var useremail = 'uye';

class AddItem extends StatefulWidget {
  static String id = 'additem';

  AddItem();

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  _AddItemState(){
    getUser();
  }

  Future getUser() async {
    User currUser;
    FirebaseAuth _auth = FirebaseAuth.instance;
    currUser =  await _auth.currentUser!;
    useremail = currUser.email!;
    print(useremail);
    setState((){
      useremail;
    });
    return currUser;
  }
  void selectAndUpload(){
    UpImg().select();
    UpImg().upload();
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;



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
          'id': useremail,
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
                  title: Text(useremail),
                  tileColor: Colors.black54,
                ),
                TextF(nameController: nameController,stri: 'Item Name', minlin: 1,maxlin: 5),
                TextF(nameController: descController,stri: 'Description', minlin: 3,maxlin: 5),
                TextF(nameController: nameController,stri: 'Price', minlin: 1,maxlin: 5),
                TextF(nameController: nameController,stri: 'Tags', minlin: 1,maxlin: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: (){selectAndUpload();}, child: Text('Photo'),),
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
    return TextField(
      minLines: minlin,
      maxLines: maxlin,
      controller: nameController,
      decoration: InputDecoration(
        hintText: stri,
        border: OutlineInputBorder(),
      ),

    );
  }
}

