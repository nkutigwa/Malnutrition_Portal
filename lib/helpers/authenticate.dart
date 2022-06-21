import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_web_dashboard/constants/string.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:typed_data' show Uint8List;

class FireStoreUtils {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference storage = FirebaseStorage.instance.ref();

  Future<User> getCurrentUser(String uid) async {
    DocumentSnapshot userDocument =
        await firestore.collection(USERS).doc(uid).get();
    if (userDocument != null && userDocument.exists) {
      return User.fromJson(userDocument.data());
    } else {
      return null;
    }
  }

  static Future<User> updateCurrentUser(User user) async {
    return await firestore
        .collection(USERS)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      print(user);
      return user;
    });
  }

  Future<String> uploadUserImageToFireStorage(File image, String userID) async {
    Reference upload = storage.child("images/$userID.png");
    UploadTask uploadTask = upload.putFile(image);

    try {
      var downloadUrl =
          await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
      print(downloadUrl.toString());
      return downloadUrl.toString();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> uploadRawImageToFireStorage(
      Uint8List data, String userID) async {
    Reference upload = storage.child("images/$userID.png");
    UploadTask uploadTask = upload.putData(
      data,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    try {
      var downloadUrl =
          await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
      print(downloadUrl.toString());
      return downloadUrl.toString();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
