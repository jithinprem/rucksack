import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


final storageRef = FirebaseStorage.instance.ref();
late XFile? image;


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