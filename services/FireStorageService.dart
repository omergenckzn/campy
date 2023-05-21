import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FireStorageService extends ChangeNotifier {
  final FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;

  Future? uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      var uploadTask = await firebaseStorageRef.ref('campyUserProfileImages/$fileName').putFile(file);
      var imageUrl = await firebaseStorageRef.ref('campyUserProfileImages/$fileName').getDownloadURL();
      return imageUrl;

    } on FirebaseException catch (e){
      return null;
    }
  }

  Future? uploadPlaceFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      var uploadTask = await firebaseStorageRef.ref('campyPlaceImages/$fileName').putFile(file);
      var imageUrl = await firebaseStorageRef.ref('campyUserPlaceImages/$fileName').getDownloadURL();
      return imageUrl;

    } on FirebaseException catch (e){
      return null;
    }
  }





}