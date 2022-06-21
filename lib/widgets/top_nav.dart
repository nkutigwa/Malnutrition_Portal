//import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/authenticate.dart';
import 'package:flutter_web_dashboard/helpers/helper.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/main.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';

import 'custom_text.dart';
//import 'profile_picture.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  void logOut() async {
    auth.User firebaseUser = auth.FirebaseAuth.instance.currentUser;
    User user = await FireStoreUtils().getCurrentUser(firebaseUser.uid);
    user.active = false;
    user.lastOnlineTimestamp = Timestamp.now();
    print(user.active);
    await FireStoreUtils.updateCurrentUser(user);
    await auth.FirebaseAuth.instance.signOut();
    MyAppState.currentUser = null;
    Get.offAllNamed(introductionPageRoute);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        //TODO Implement LogoOut
        logOut();
        break;
      case 'Settings':
        //TODO Go to Accoount Settings

        break;
    }
  }

  return AppBar(
//    toolbarHeight: 70.0,
    leading: !ResponsiveWidget.isSmallScreen(context)
        ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset(
                  "assets/icons/logo.png",
                  width: 28,
                ),
              ),
            ],
          )
        : IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              key.currentState.openDrawer();
            }),
    title: Container(
      child: Row(
        children: [
          Visibility(
              visible: !ResponsiveWidget.isSmallScreen(context),
              child: CustomText(
                text: "VPIMS",
                color: lightGrey,
                size: 20,
                weight: FontWeight.bold,
              )),
          Expanded(child: Container()),
//          IconButton(
//              icon: Icon(
//                Icons.settings,
//                color: dark,
//              ),
//              onPressed: () {
//                PopupMenuButton<String>(
//                  onSelected: handleClick,
//                  itemBuilder: (BuildContext context) {
//                    return {'Logout', 'Settings'}.map((String choice) {
//                      return PopupMenuItem<String>(
//                        value: choice,
//                        child: Text(choice),
//                      );
//                    }).toList();
//                  },
//                );
//              }),
          Stack(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: dark.withOpacity(.7),
                  ),
                  onPressed: () {}),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: light, width: 2)),
                ),
              )
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          SizedBox(
            width: 24,
          ),
          CustomText(
            text: MyAppState.currentUser.firstName +
                " " +
                MyAppState.currentUser.lastName,
            color: lightGrey,
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
                color: active.withOpacity(.5),
                borderRadius: BorderRadius.circular(30)),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                  backgroundColor: light,
//                  radius: 25.0,
                  child:
//                Icon(
//                  Icons.person_outline,
//                  color: dark,
//                ),
//                  Method1 if Saved Raw Data
//                    ProfilePic(),
                      displayCircleImage(
                          MyAppState.currentUser.profilePictureURL, 65, false)
                  //Method 3
//                    MyAppState.currentUser.profilePictureURL != null
//                        ?

//                    Image.network(
//                            MyAppState.currentUser.profilePictureURL,
//                            fit: BoxFit.contain,
////                            height: 40.0,
//                          )
//                        : Icon(
//                            Icons.person_outline,
//                            color: dark,
//                          ),
                  ),
            ),
          )
        ],
      ),
    ),
    actions: <Widget>[
      PopupMenuButton<String>(
        onSelected: handleClick,
        itemBuilder: (BuildContext context) {
          return {'Settings', 'Logout'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    ],
    iconTheme: IconThemeData(color: dark),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
