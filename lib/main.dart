import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/controllers/menu_controller.dart';
import 'package:flutter_web_dashboard/controllers/navigation_controller.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashboard/pages/introduction/introduction.dart';
import 'package:flutter_web_dashboard/pages/signUp/choose_role_page.dart';
import 'package:flutter_web_dashboard/pages/signUp/sign_up.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'helpers/authenticate.dart';
import 'models/user.dart';
import 'pages/authentication/forgot_password.dart';
import 'routing/routes.dart';

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static User currentUser;
  StreamSubscription tokenStream;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return PageNotFound(
              errorMessage: "Firebase Failed to Initialize",
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
//      initialRoute: authenticationPageRoute,
              initialRoute: introductionPageRoute,
              unknownRoute: GetPage(
                  name: '/not-found',
                  page: () => PageNotFound(),
                  transition: Transition.fadeIn),
              getPages: [
                GetPage(
                    name: rootRoute,
                    page: () {
                      return SiteLayout();
                    }),
                GetPage(
                    name: authenticationPageRoute,
                    page: () => AuthenticationPage()),
                GetPage(name: signUpPageRoute, page: () => SignUpScreen()),
                GetPage(
                    name: chooseRolePageRoute, page: () => ChooseRolePage()),
                GetPage(name: introductionPageRoute, page: () => IntroScreen()),
                GetPage(
                    name: forgetPasswordPageRoute,
                    page: () {
                      return ForgotPassword();
                    }),
              ],
              debugShowCheckedModeBanner: false,
              title: 'VPIMS',
              theme: ThemeData(
                scaffoldBackgroundColor: light,
                textTheme:
                    GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.black),
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                }),
                primarySwatch: Colors.blue,
              ),
              // home: AuthenticationPage(),
            );
          }
          return Container();
        });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (auth.FirebaseAuth.instance.currentUser != null && currentUser != null) {
      if (state == AppLifecycleState.paused) {
        //user offline
        tokenStream.pause();
        currentUser.active = false;
        currentUser.lastOnlineTimestamp = Timestamp.now();
        FireStoreUtils.updateCurrentUser(currentUser);
      } else if (state == AppLifecycleState.resumed) {
        //user online
        tokenStream.resume();
        currentUser.active = true;
        FireStoreUtils.updateCurrentUser(currentUser);
      }
    }
  }
}
