import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:flutter_web_dashboard/pages/account/account.dart';
import 'package:flutter_web_dashboard/pages/account/reset_password.dart';
import 'package:flutter_web_dashboard/pages/authentication/forgot_password.dart';
//import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashboard/pages/districts/districts.dart';
import 'package:flutter_web_dashboard/pages/districts/other_districts_data.dart';
//import 'package:flutter_web_dashboard/pages/introduction/introduction.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/pages/regions/region.dart';
import 'package:flutter_web_dashboard/pages/school/test.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
//import 'package:get/get.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
//  if (settings.name.startsWith(districtsPageRoute)) {
//    final subRoute = settings.name.substring(
//      districtsPageRoute.length,
//    );
//    switch (settings.name) {
//      case overviewPageRoute:
//        return _getPageRoute(OverviewPage());
//      case regionsPageRoute:
//        return _getPageRoute(DriversPage());
//      case districtsPageRoute:
//        return _getPageRoute(ClientsPage());
//    }
//  }
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case regionPageRoute:
      return _getPageRoute(RegionPage());
    case districtsPageRoute:
      return _getPageRoute(DistrictsPage());
    //TODO Add Account Settings Page
    case accountSettingsPageRoute:
      return _getPageRoute(AccountPage());
    case forgetPasswordPageRoute:
      return _getPageRoute(ForgotPassword());
    case resetPasswordPageRoute:
      return _getPageRoute(ResetPassword());
    case otherDistrictsPageRoute:
//      var args = Get.arguments;
      return _getPageRoute(OtherDistrictsPage(
//        districtName: args[0],
          ));
    case schoolPageRoute:
      return _getPageRoute(SchoolPage());
    default:
      return _getPageRoute(PageNotFound());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
