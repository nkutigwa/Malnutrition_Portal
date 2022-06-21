import 'dart:io';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_dashboard/constants/string.dart';
import 'package:flutter_web_dashboard/helpers/search.dart';
import 'package:flutter_web_dashboard/helpers/helper.dart';
import 'package:flutter_web_dashboard/helpers/authenticate.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/pages/signUp/choose_role_page.dart';
//import 'package:flutter_login_screen/constants.dart';
//import 'package:flutter_login_screen/main.dart';
//import 'package:flutter_login_screen/model/search.dart';
//import 'package:flutter_login_screen/model/user.dart';
//import 'package:flutter_login_screen/services/authenticate.dart';
//import 'package:flutter_login_screen/services/helper.dart';
//import 'package:flutter_login_screen/ui/auth/authScreen.dart';
//import 'package:flutter_login_screen/ui/home/homeScreen.dart';
//import 'package:flutter_login_screen/ui/home/homeScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:html' as html;

import '../../main.dart';

File _image;
//var imageFile;
var imageForSendToAPI;

class SignUpScreen extends StatefulWidget {
  final String role;

  SignUpScreen({Key key, this.role}) : super(key: key);
  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String firstName,
      lastName,
      email,
      mobile,
      password,
      confirmPassword,
      districtName,
      regionName,
      schoolName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: new Container(
            constraints: BoxConstraints(maxWidth: 500),
            margin: new EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: new Form(
              key: _key,
              autovalidateMode: _validate,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

//  Future<void> retrieveLostData() async {
//    final LostData response = await _imagePicker.getLostData();
//    if (response == null) {
//      return;
//    }
//    if (response.file != null) {
//      setState(() async {
//        _image = File(response.file.path);
//        imageForSendToAPI = await _image.readAsBytes();
//      });
//    }
//  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Add profile picture",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
//            PickedFile image =
//                await _imagePicker.getImage(source: ImageSource.gallery);
            XFile image =
                await _imagePicker.pickImage(source: ImageSource.gallery);
            imageForSendToAPI = await image.readAsBytes();
            if (image != null) {
              setState(() {
//                imageFile = html.File(image.path.codeUnits, image.path);
                _image = File(image.path);
                print(image.path);
              });
            } else {
              print("NO file selected");
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.camera);
            imageForSendToAPI = await image.readAsBytes();
            if (image != null)
              setState(() {
//                imageFile = html.File(image.path.codeUnits, image.path);
                _image = File(image.path);
                print(image.path);
              });
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Widget formUI() {
    return new Column(
      children: <Widget>[
        new Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Create new account',
              style: TextStyle(
                  color: active, fontWeight: FontWeight.bold, fontSize: 25.0),
            )),
        Padding(
          padding:
              const EdgeInsets.only(left: 8.0, top: 32, right: 8, bottom: 8),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey.shade400,
                child: ClipOval(
                  child: SizedBox(
                    width: 170,
                    height: 170,
//                    child: imageFile == null
                    child: _image == null
                        ? Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.cover,
                          )
                        : Image.memory(
                            imageForSendToAPI,
//                            _image,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                right: 0,
                child: FloatingActionButton(
                    backgroundColor: active,
                    child: Icon(Icons.camera_alt),
                    mini: true,
                    onPressed: _onCameraClick),
              )
            ],
          ),
        ),

        /// If a School Admin has Ability to Select School
        ChooseRolePage.userRole == schoolAdmin
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                  maxHeight: 65.0,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                  child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      autoFocusSearchBox: false,
                      showSelectedItem: true,
                      showSearchBox: true,
//              compareFn: (i, s) => i.isEqual(s),
//              label: 'School Name',
                      onFind: (filter) => Search.search(filter, School.schools),
//              onBeforeChange: ,

                      items: School.schools ??
                          [
                            "School",
                            "Marian",
                            "Ilboru (Disabled)",
                            "Temeke boys",
                            'St.Marys'
                          ],
                      dropdownSearchDecoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          fillColor: Colors.white,
                          hintText: 'School',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: active, width: 2.0)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      validator: (String item) {
                        if (item == null || item == "School")
                          return "Required field";
                        else if (item == "Brazil")
                          return "Invalid item";
                        else
                          return null;
                      },
                      hint: "Region",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (value) {
                        schoolName = value;
//                        print(schoolName);
                      },
                      selectedItem: "School"),
                ),
              )
            : Container(),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            maxHeight: 65.0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
            child: DropdownSearch<String>(
                mode: Mode.MENU,
                autoFocusSearchBox: false,
                showSelectedItem: true,
                showSearchBox: true,
//              compareFn: (i, s) => i.isEqual(s),
//              label: 'School Name',
                onFind: (filter) => Search.search(
                      filter,
                      ChooseRolePage.districts,
                    ),
//              onBeforeChange: ,

                items: ChooseRolePage.districts,
                dropdownSearchDecoration: InputDecoration(
                    contentPadding:
                        new EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    fillColor: Colors.white,
                    hintText: 'Districts',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: active, width: 2.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                validator: (String item) {
                  if (item == null || item == "District")
                    return "Required field";
                  else if (item == "Municipal")
                    return "Invalid item";
                  else
                    return null;
                },
                hint: "District",
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (value) {
                  districtName = value;
//                  print(districtName);
                },
                selectedItem: "District"),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            maxHeight: 65.0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
            child: DropdownSearch<String>(
                mode: Mode.MENU,
                autoFocusSearchBox: false,
                showSelectedItem: true,
                showSearchBox: true,
//              compareFn: (i, s) => i.isEqual(s),
//              label: 'School Name',
                onFind: (filter) => Search.search(
                      filter,
                      ChooseRolePage.regions,
                    ),
//              onBeforeChange: ,

                items: ChooseRolePage.regions,
                dropdownSearchDecoration: InputDecoration(
                    contentPadding:
                        new EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    fillColor: Colors.white,
                    hintText: 'Region',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: active, width: 2.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                validator: (String item) {
                  if (item == null || item == "Region")
                    return "Required field";
                  else if (item == "Regions")
                    return "Invalid item";
                  else
                    return null;
                },
                hint: "Region",
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (value) {
                  regionName = value;
                  print(regionName);
                },
                selectedItem: "Region"),
          ),
        ),
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                    validator: validateName,
                    onSaved: (String val) {
                      firstName = val;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        fillColor: Colors.white,
                        hintText: 'First Name',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: active, width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))))),
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                    validator: validateName,
                    onSaved: (String val) {
                      lastName = val;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        fillColor: Colors.white,
                        hintText: 'Last Name',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: active, width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))))),
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    validator: validateMobile,
                    onSaved: (String val) {
                      mobile = val;
                    },
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        fillColor: Colors.white,
                        hintText: 'Mobile Number',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: active, width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))))),
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    validator: validateEmail,
                    onSaved: (String val) {
                      email = val;
                    },
                    decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        fillColor: Colors.white,
                        hintText: 'Email Address',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(color: active, width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))))),
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: double.infinity),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
              child: TextFormField(
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  controller: _passwordController,
                  validator: validatePassword,
                  onSaved: (String val) {
                    password = val;
                  },
                  style: TextStyle(height: 0.8, fontSize: 18.0),
                  cursorColor: active,
                  decoration: InputDecoration(
                      contentPadding:
                          new EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      fillColor: Colors.white,
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: active, width: 2.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ))),
            )),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
            child: TextFormField(
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  _sendToServer();
                },
                obscureText: true,
                validator: (val) =>
                    validateConfirmPassword(_passwordController.text, val),
                onSaved: (String val) {
                  confirmPassword = val;
                },
                style: TextStyle(height: 0.8, fontSize: 18.0),
                cursorColor: active,
                decoration: InputDecoration(
                    contentPadding:
                        new EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    fillColor: Colors.white,
                    hintText: 'Confirm Password',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: active, width: 2.0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: RaisedButton(
              color: active,
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              splashColor: active,
              onPressed: _sendToServer,
              padding: EdgeInsets.only(top: 12, bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: active)),
            ),
          ),
        ),
      ],
    );
  }

  _sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      showProgress(context, 'Creating new account, Please wait...', false);
      var profilePicUrl = '';
      try {
        auth.UserCredential result = await auth.FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim())
            .whenComplete(() => print('true'));
//        await auth.FirebaseAuth.instance.currentUser
//            .updateProfile(displayName: firstName, photoURL: profilePicUrl);

        await result.user.sendEmailVerification();

        if (_image != null) {
          updateProgress('Uploading image, Please wait...');
          profilePicUrl = await FireStoreUtils()
//              .uploadUserImageToFireStorage(_image, result.user.uid);
              .uploadRawImageToFireStorage(imageForSendToAPI, result.user.uid);
        }
        await result.user.updatePhotoURL(profilePicUrl);
        await result.user.updateDisplayName(firstName + " " + lastName);
        User user = User(
            email: email,
            firstName: firstName,
            phoneNumber: mobile,
            region: regionName,
            district: districtName,
            role: ChooseRolePage.userRole,
            userID: result.user.uid,
            active: true,
            lastName: lastName,
            schoolName: schoolName,
            profilePictureURL: profilePicUrl);
        await FireStoreUtils.firestore
            .collection(USERS)
            .doc(result.user.uid)
            .set(user.toJson());
        hideProgress();

        ///TODO MyAppState
        MyAppState.currentUser = user;
//        pushAndRemoveUntil(context, HomeScreen(user: user), false);
//        pushAndRemoveUntil(context, AvailableFoodsScreen(user: user), false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("schoolName", schoolName);
        prefs.setString("regionName", regionName);
        prefs.setString("districtName", districtName);
//        AuthScreen.user.schoolName = user.schoolName;

        //If school collection doesn't exist create
//        final snapshot = await FireStoreUtils.firestore
//            .collection("schools")
//            .where("name", isEqualTo: schoolName)
//            .get()
//            .catchError((onError) => print("$onError"));
//        addSchool(schoolName, snapshot);
//        Get.to(rootRoute);
        Get.offAllNamed(rootRoute);
//        push(context, HomeScreen(user: user));
      } on auth.FirebaseAuthException catch (error) {
        hideProgress();
        String message = 'Couldn\'t sign up';
        switch (error.code) {
          case 'email-already-in-use':
            message = 'Email address already in use';
            break;
          case 'invalid-email':
            message = 'validEmail';
            break;
          case 'operation-not-allowed':
            message = 'Email/password accounts are not enabled';
            break;
          case 'weak-password':
            message = 'password is too weak.';
            break;
          case 'too-many-requests':
            message = 'Too many requests, '
                'Please try again later.';
            break;
        }
        showAlertDialog(context, 'Failed', message);
        print(error.toString());
      } catch (e) {
        print('_SignUpState._sendToServer $e');
        hideProgress();
        showAlertDialog(context, 'Failed', 'Couldn\'t sign up' + e.toString());
      }
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _image = null;
    super.dispose();
  }
}
