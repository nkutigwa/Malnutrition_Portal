import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_dashboard/constants/string.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
//import 'package:flutter_web_dashboard/models/student.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';
//import 'package:flutter_web_dashboard/pages/regions/widgets/data_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseRolePage extends StatelessWidget {
  static String userRole = schoolAdmin;
  static List<String> regions = [];
  static List<String> districts = [];

  Future<void> fetchData() async {
    ///Fetch data from JSON from asset
    final String response = await rootBundle.loadString('assets/Regions.json');
    final String responsee =
        await rootBundle.loadString('assets/Districts.json');
    final dataa = await json.decode(responsee);
    final data = await json.decode(response);
    var dist = data["features"];
    int len = dist.length;
//    print(len);
    int i = 0;
    while (i < len) {
      regions.add(dist[i]["properties"]["region"].toString());
      i++;
    }
//    print(regions);

    var distt = dataa["features"];
    int lenn = distt.length;
//    print(lenn);
    int j = 0;
    while (j < lenn) {
      var reg = distt[j]["properties"]["region"].toString();
      districts.add(distt[j]["properties"]["District"].toString());
      j++;
    }
//    print(districts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'What is your Role?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: active,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
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
                      'School Administrator',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    splashColor: active,
                    onPressed: () async {
                      ChooseRolePage.userRole = schoolAdmin;
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("userRole", ChooseRolePage.userRole);
                      await fetchData()
                          .whenComplete(() => Get.toNamed(signUpPageRoute));
//                      Get.toNamed(signUpPageRoute);
                    },
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
                      'District Nutritional Officer',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: active),
                    ),
                    onPressed: () async {
                      ChooseRolePage.userRole = districtOfficer.toString();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("userRole", ChooseRolePage.userRole);
                      await fetchData()
                          .whenComplete(() => Get.toNamed(signUpPageRoute));
//                      Get.toNamed(signUpPageRoute);
                    },
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
//                        side: BorderSide(color: Color(COLOR_PRIMARY))
                    ),
                  ),
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
                      'Regional Nutritonal Officer',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    splashColor: active,
                    onPressed: () async {
                      ChooseRolePage.userRole = regionOfficer.toString();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("userRole", ChooseRolePage.userRole);
                      await fetchData()
                          .whenComplete(() => Get.toNamed(signUpPageRoute));
                    },
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
//                        side: BorderSide(color: Color(COLOR_PRIMARY))
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
