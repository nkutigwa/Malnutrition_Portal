import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';

class ConfirmEmail extends StatelessWidget {
  static String id = 'confirm-email';
  final String message;

  const ConfirmEmail({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Row(
        children: [
          Container(
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
          ),
          FlatButton(
            child: Text('Go to Sign In'),
            onPressed: () {
              Get.toNamed(authenticationPageRoute);
            },
          ),
        ],
      ),
    );
  }
}
