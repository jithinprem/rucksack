import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpImg extends StatefulWidget {
  static String id = 'upimg';
  const UpImg({Key? key}) : super(key: key);

  @override
  State<UpImg> createState() => _UpImgState();
}

class _UpImgState extends State<UpImg> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              ElevatedButton(onPressed: QuickImgUp().select, child: Text('selectfile')),
              ElevatedButton(onPressed: upload, child: Text('upload')),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickImgUp{

  final storageRef = FirebaseStorage.instance.ref();
  late final XFile? image;

  void select() async {
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void upload() async {
    final mountainsRef = storageRef.child('/items/'+DateTime.now().toString()+'.jpg');
    File myFile = File(image!.path);
    try {
      await mountainsRef.putFile(myFile);
    } catch (e) {
      print(e);
    }
    final String dfileUrl = await mountainsRef.getDownloadURL();
    print('this is the download url');
    print(dfileUrl);
  }


}
