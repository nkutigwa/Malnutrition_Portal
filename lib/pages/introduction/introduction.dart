import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = '/authScreen';
//  static User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        key: context.read<MenuController>().scaffoldKey,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.bar_chart,
                  size: 150,
//                  color: Color(COLOR_PRIMARY),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 32, right: 16, bottom: 8),
                child: Text(
                  'Welcome to Malnutrition Portal!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: active,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Text(
                  'Evidence of Malnutrition for adolescent',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: RaisedButton(
                    color: active,
                    child: Text(
                      'Log In',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    splashColor: active,
                    onPressed: () => Get.toNamed(authenticationPageRoute),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
//                        side: BorderSide(color: Color(COLOR_PRIMARY))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 40.0, left: 40.0, top: 20, bottom: 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: FlatButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: active),
                    ),
                    onPressed: () => Get.toNamed(chooseRolePageRoute),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
//                        side: BorderSide(color: Color(COLOR_PRIMARY))
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
