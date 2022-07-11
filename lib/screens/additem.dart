import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rucksack/screens/profilescreen.dart';
import 'dart:io';
import 'imageupload/imgupload.dart';
//import 'package:rucksack/functions/upImage.dart';

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
    getProfilepic();
  }

  final storageRef = FirebaseStorage.instance.ref();
  XFile? image = XFile('');
  var imgWidget = NetworkImage('https://www.dreamstime.com/no-image-available-icon-photo-camera-flat-vector-illustration-image132483141');
  User? currUser;
  String dfileUrl = '';
  List<String> dfiles = [];
  String? profilePicUrl;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  getProfilepic() async{
    var searchresult = [];
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? currUser = _auth.currentUser;
    var uid = currUser!.uid;

    var result = await FirebaseFirestore.instance.collection('profile').where(
      'uid', isEqualTo: uid,
    ).get();

    searchresult = await result.docs.map((e) => e.data()).toList();
    setState((){
      profilePicUrl = searchresult[0]['profilepic'];
    });
    return searchresult[0]['profilepic'];
  }

  select() async {
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    // ImagePicker imagePicker = ImagePicker();
    // image = await imagePicker.pickImage(
    //   source: ImageSource.camera,
    //   imageQuality: 35,
    //);
  }

  upload(val) async {
    final mountainsRef = storageRef.child('/$val/'+DateTime.now().toString()+'.jpg');
    File myFile = File(image!.path);
    try {
      await mountainsRef.putFile(myFile);
    } catch (e) {
      print(e);
    }
    dfileUrl = await mountainsRef.getDownloadURL();
    dfiles.add(dfileUrl);
    setState((){
      dfiles;
    });
    print('the dfiles array is -');
    print(dfiles);
  }

  Future getUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    currUser =  await _auth.currentUser!;
    useremail = currUser!.email!;
    print(useremail);
    setState((){
      useremail;
    });
    return currUser;
  }

  void selectAndUpload(val) async{
      await select();
      print('select is complete');
      await upload(val);
      print('upload is complete');
      updateIconstoImg(dfiles[0]);
  }

  updateIconstoImg(url){
    setState((){
        imgWidget = NetworkImage(url);
    });
  }

  void UploadItem() async{
      var itemname = nameController.text;
      var descitem = descController.text;
      var priceitem = priceController.text;
      var tags = tagsController.text;

      profilePicUrl = await getProfilepic();

      if(itemname != Null && descitem != Null && priceitem != Null) {
        print('uploading is being performed......................');
        await _firestore.collection('allitems').add({
          'description': descitem,
          'id': useremail,
          'name': itemname,
          'price': priceitem,
          'tags': tags,
          'userid' : currUser!.uid,
          'item_image' : dfiles,
          'profile_pic' : profilePicUrl,
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
          resizeToAvoidBottomInset: false,
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(useremail),
                  tileColor: Colors.black38,
                ),
                SizedBox(
                  height: 22,
                ),
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          TextF(nameController: nameController,stri: 'Item Name', minlin: 1,maxlin: 5),
                          TextF(nameController: descController,stri: 'Description', minlin: 3,maxlin: 5),
                          TextF(nameController: priceController,stri: 'Price', minlin: 1,maxlin: 5),
                          TextF(nameController: tagsController,stri: 'Tags in', minlin: 1,maxlin: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              image: DecorationImage(image: imgWidget,
                                  fit: BoxFit.cover)
                          ),
                        ),
                        onPressed: (){
                          //upload the image
                          selectAndUpload('items');
                        },
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        child: Icon(Icons.add),
                        color: Colors.black,
                      ),
                      Container(
                        height:80,
                        width: 80,
                        child: Icon(Icons.add),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //ElevatedButton(onPressed: (){selectAndUpload('items');}, child: Text('Photo'),),
                        ElevatedButton(onPressed: (){getProfilepic();}, child: Text('Photo'),),
                        ElevatedButton(onPressed: (){UploadItem();}, child: Text('Add'),),
                      ],
                    ),
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

    );
  }
}

