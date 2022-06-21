import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/string.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/authenticate.dart';
import 'package:flutter_web_dashboard/helpers/helper.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/pages/signUp/choose_role_page.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
//import 'package:flutter_web_dashboard/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../main.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Form(
            key: _key,
            autovalidateMode: _validate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("Login",
                        style: GoogleFonts.roboto(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Welcome back to the Malnutrition Portal.",
                      color: lightGrey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,
                  validator: validateEmail,
                  onSaved: (String val) {
                    email = val;
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "abc@domain.com",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,
                  validator: validatePassword,
                  obscureText: true,
                  onSaved: (String val) {
                    password = val;
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "123456@pass",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
//                CustomTextField(
//                  validator: validatePassword,
//                  obscureText: true,
//                  hintText: "Password",
//                  onSaved: (String val) {
//                    password = val;
//                  },
//                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
//                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        CustomText(
                          text: "Remember Me",
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(forgetPasswordPageRoute);
                        },
                        child:
                            CustomText(text: "Forgot password?", color: active))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    await login();
//                  Get.offAllNamed(rootRoute);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: active, borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CustomText(
                      text: "Login",
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.offAllNamed(signUpPageRoute);
                  },
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Do not have Login credentials? "),
                    TextSpan(text: "Sign Up ", style: TextStyle(color: active))
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sharedUserRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role);
    ChooseRolePage.userRole = role;
  }

  login() async {
    ///Old Code
    if (_key.currentState.validate()) {
      _key.currentState.save();
      showProgress(context, 'Logging in, please wait...', false);
      User user = await loginWithUserNameAndPassword();

      if (user != null) Get.offAllNamed(rootRoute);

      ///Test
//        push(context, MainScreen(schoolName: user.schoolName.toString()));
//        pushAndRemoveUntil(context, ConfirmEmail(), false);
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  Future<User> loginWithUserNameAndPassword() async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .whenComplete(() => print('true'));
      DocumentSnapshot documentSnapshot = await FireStoreUtils.firestore
          .collection(USERS)
          .doc(result.user.uid)
          .get()
          .whenComplete(() => print("documentSnapshot"));
      print(documentSnapshot.exists);
      User user;
      if (documentSnapshot != null && documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data());
        user.active = true;
        await FireStoreUtils.updateCurrentUser(user);
        _sharedUserRole(user.role);

        ///
//        print(user);
        hideProgress();
//        AuthScreen.user.schoolName = user.schoolName;
        MyAppState.currentUser = user;
//        return null;
      }
      return user;
    }
//    on PlatformException catch (e) {
//      print(e.message);
//    }
    on auth.FirebaseAuthException catch (exception) {
      hideProgress();
      switch ((exception).code) {
        case "invalid-email":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'malformedEmail');
          break;
        case "wrong-password":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'Wrong password');
          break;
        case "user-not-found":
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'No user corresponds to this email');
          break;
        case "user-disabled":
          showAlertDialog(
              context, 'Couldn\'t Authenticate', 'This user is disabled');
          break;
        case 'too-many-requests':
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'Too many requests, Please try again later.');
          break;
      }
      print(exception.toString());
      return null;
    } catch (e) {
      hideProgress();
      showAlertDialog(
          context, 'Couldn\'t Authenticate', 'Login failed. Please try again.');
      print(e.toString());
      return null;
    }
  }

  _loginWithEmailAndPassword() async {
    await showProgress(context, 'Logging in, please wait...', false);
    dynamic result = await auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .whenComplete(() => print('true'));
//    dynamic result = await FireStoreUtils.loginWithEmailAndPassword(
//        email.trim(), password.trim());
    await hideProgress();
    if (result != null && result is User) {
      MyAppState.currentUser = result;
      Get.offAllNamed(rootRoute);
//      pushAndRemoveUntil(context, HomeScreen(user: result), false);
    } else if (result != null && result is String) {
      showAlertDialog(context, 'Couldn\'t Authenticate', result);
    } else {
      showAlertDialog(
          context, 'Couldn\'t Authenticate', 'Login failed, Please try again.');
    }
  }
}
