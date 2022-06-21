import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/authenticate.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/main.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:flutter_web_dashboard/widgets/side_menu_item.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  void logOut() async {
    auth.User firebaseUser = auth.FirebaseAuth.instance.currentUser;
    User user = await FireStoreUtils().getCurrentUser(firebaseUser.uid);
    user.active = false;
    user.lastOnlineTimestamp = Timestamp.now();
    print(user.active);
    await FireStoreUtils.updateCurrentUser(user);
    await auth.FirebaseAuth.instance.signOut();
    MyAppState.currentUser = null;
    Get.offAllNamed(authenticationPageRoute);
//    Get.offAllNamed(introductionPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "VPIMS",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (item.route == authenticationPageRoute) {
                        logOut();
                        menuController
                            .changeActiveItemTo(overviewPageDisplayName);
                      }
                      if (item.route == introductionPageRoute) {
                        Get.offAllNamed(introductionPageRoute);
                        menuController
                            .changeActiveItemTo(overviewPageDisplayName);
                      }
//                      if (item.route == introductionPageRoute) {
//                        Get.offAllNamed(introductionPageRoute);
//                        menuController
//                            .changeActiveItemTo(overviewPageDisplayName);
//                      }
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                        navigationController.navigateTo(item.route);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
