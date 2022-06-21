import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';

import '../main.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String val = MyAppState.currentUser.userID;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Uint8List> getData() async {
    Reference storage = FirebaseStorage.instance.ref().child("images/$val.png");
    Uint8List dt = await storage.getData();
    print(dt);
    return dt;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          child = Image.memory(
            snapshot.data,
            fit: BoxFit.contain,
          );
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          print(snapshot.data);
          child = const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          );
        } else {
          child =
//            SizedBox(
//              child: CircularProgressIndicator(),
//              width: 60,
//              height: 60,
//            );
              Icon(
            Icons.person_outline,
            color: dark,
          );
        }
        return child;
      },
    );
  }
}
