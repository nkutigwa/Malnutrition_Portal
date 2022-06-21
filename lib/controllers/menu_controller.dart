import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = overviewPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;
  Future<String> checkRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role');
    return role;
  }

  String getRole() {
    String role = "";
    checkRole().then((value) {
      role = value;
    });
    return role;
  }

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case regionPageDisplayName:
        return _customIcon(Icons.vrpano, itemName);
      case districtsPageDisplayName:
        return _customIcon(Icons.widgets_outlined, itemName);
      case accountSettingsPageDisplayName:
        return _customIcon(Icons.person, itemName);
      case schoolPageDisplayName:
        return _customIcon(Icons.school, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: dark);

    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
