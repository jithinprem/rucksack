import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rucksack/mywidget/dropdown.dart';
import 'package:rucksack/screens/additem.dart';
import 'package:rucksack/screens/homescreen.dart';
import 'package:image_picker/image_picker.dart';

import '../../functions/upImage.dart';

class ProfileDet extends StatefulWidget {
  static String id = 'profiledet';
  User? user;
  ProfileDet(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
  }

  @override
  State<ProfileDet> createState() => _ProfileDetState();
}

class _ProfileDetState extends State<ProfileDet> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  XFile? image = XFile('');
  var imgWidget =  NetworkImage('https://images.unsplash.com/photo-1658518832556-9d3fcbf51be8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyN3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60');

  //to get user info or uid
  final FirebaseAuth auth = FirebaseAuth.instance;
  var uid;
  inputData() {
    uid = widget.user?.uid;
    // here you write the codes to input the data into firestore
  }

  //spinning boolean
  bool showSpinner = false;
  setspinning(){
    setState((){
      if(showSpinner == true){
        showSpinner = false;
      }
      else{
        showSpinner = true;
      }
    });
  }


  //function to pic image
  select() async {
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.gallery);
  }

  //function to upload image to val folder in firebase storage
  late String dfileUrl ='';
  upload(val) async {
    final mountainsRef = storageRef.child('users/'+DateTime.now().toString()+'.jpg');
    File myFile = File(image!.path);
    try {
      await mountainsRef.putFile(myFile);
    } catch (e) {
      print(e);
    }
    dfileUrl = await mountainsRef.getDownloadURL();
    print('this is the download url');
    print(dfileUrl);
    return Future(() => null);
  }

  //change the circle avatar
  updateIconstoImg(url){
    setState((){
      imgWidget = NetworkImage(url);
    });
  }
  void selectAndUpload(val) async{
    await select();
    Future.delayed(Duration(seconds: 5), (){ print("Executed after 5 seconds"); });
    print('select is complete, spinning has started');
    setspinning();
    await upload(val);
    print('upload is complete here');
    updateIconstoImg(dfileUrl);
    setspinning();
    print('spinning is complete');
  }

  void UploadItem() async{
    var personname = nameController.text;
    var personaddress = addressController.text;
    var mobno = contactController.text;
    List <String> wishitems = [];

    if(personname != Null && personaddress != Null && mobno != Null) {
      print('uploading is being performed......................');
      await _firestore.collection('profile').doc(widget.user?.email.toString()).set({
        'address': personaddress,
        'contact': mobno,
        'name': personname,
        'degree': D1.mystr,
        'branch': D2.mystr,
        'year' : D3.mystr,
        'uid' : uid,
        'profilepic': dfileUrl,
        'witem' : wishitems,
      });
      Navigator.pushNamed(context, HomeScreen.id);
    }

  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();

  final List<String> degreeitems = ['Btech', 'Mtech',];
  final List<String> branchitems = ['cse', 'Mech', 'ec', 'eee', 'civil', 'chemical'];
  final List<String> yearitems = ['1', '2', '3', '4'];

  DropD D1 = DropD();
  DropD D2 = DropD();
  DropD D3 = DropD();

  String? degree, branch, year;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Welcome to Rucksack'),),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              selectAndUpload('users');
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: imgWidget,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: ListView(
                      padding: EdgeInsets.all(15),
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextF(nameController: nameController, stri: 'Full Name',),
                            SizedBox(height: 10,),
                            TextF(nameController: addressController, stri: 'Address/ Hostel, Room No.', minlin: 3,),
                            TextF(nameController: contactController, stri: 'Contact Number',),
                            SizedBox(height: 10,),
                            D1.DropDown('Degree', degreeitems, degree),
                            SizedBox(height: 10,),
                            D2.DropDown('Branch', branchitems, branch),
                            D3.DropDown('Year', yearitems, year),
                            SizedBox(height: 30,),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () async{
                                  await inputData();
                                  UploadItem();
                                },
                                child: const Text('Submit', style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ],
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