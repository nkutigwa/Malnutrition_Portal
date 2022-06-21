//import 'package:shared_preferences/shared_preferences.dart';

const rootRoute = "/";

const introductionPageDisplayName = "Introduction";
const introductionPageRoute = "/introduction";

const forgetPasswordDisplayName = "Forget Password";
const forgetPasswordPageRoute = "/forget-password";
const resetPasswordDisplayName = "Reset Password";
const resetPasswordPageRoute = "/Reset Password";

///Sign Up Page
const signUpPageDisplayName = "Sign Up";
const signUpPageRoute = "/signUp";
const chooseRolePageDisplayName = "Role";
const chooseRolePageRoute = "/role";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/ ";

///School Menu Item Pages
const schoolPageDisplayName = "Schools"; //If SA
const schoolPageRoute = "/schools";

const listOfSchoolsInRegionPageDisplayName = "Schools In Region"; //If RNO
const listOfSchoolsInRegionPageRoute = "/regions/listOfSchools";

const listOfSchoolsInDistrictPageDisplayName = "Schools In District"; //If DNO
const listOfSchoolsInDistrictPageRoute = "/districts/listOfSchools";

///District Menu Item Pages

const districtsPageDisplayName = "Districts"; //If DNO & SA
const districtsPageRoute = "/districts";

const otherDistrictsPageDisplayName = "Other District\'s";
const otherDistrictsPageRoute = "/other districts";

const listOfDistrictsInRegionPageDisplayName = "Districts In Region"; //If RNO
const listOfDistrictsInRegionPageRoute = "/listOfDistrictsInRegion";

///Region Menu Item Pages
const regionPageDisplayName = "Regions"; //If RNO & SA
const regionPageRoute = "/region";

const listOfRegionsPageDisplayName = "List of Regions";
const listOfRegionsPageRoute = "/region/listOfRegions";

///Login Page
const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

///Account Setting Page
const accountSettingsPageDisplayName = "Account Settings";
const accountSettingsPageRoute = "/account";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(regionPageDisplayName, regionPageRoute),
  MenuItem(districtsPageDisplayName, districtsPageRoute),
  MenuItem(schoolPageDisplayName, schoolPageRoute),
  MenuItem(accountSettingsPageDisplayName, accountSettingsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];

/////RNO Menu Item
//List<MenuItem> rnoSideMenuItemRoutes = [
//  MenuItem(overviewPageDisplayName, overviewPageRoute),
//  MenuItem(
//      listOfSchoolsInRegionPageDisplayName, listOfSchoolsInRegionPageRoute),
//  MenuItem(
//      listOfDistrictsInRegionPageDisplayName, listOfDistrictsInRegionPageRoute),
//  MenuItem(regionPageDisplayName, regionPageRoute),
//  MenuItem(accountSettingsPageDisplayName, accountSettingsPageRoute),
//  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
//];
//
/////DNO Menu Item
//List<MenuItem> dnoSideMenuItemRoutes = [
//  MenuItem(overviewPageDisplayName, overviewPageRoute),
//  MenuItem(
//      listOfSchoolsInDistrictPageDisplayName, listOfSchoolsInDistrictPageRoute),
//  MenuItem(districtsPageDisplayName, districtsPageRoute),
//  MenuItem(listOfRegionsPageDisplayName, listOfRegionsPageRoute),
//  MenuItem(accountSettingsPageDisplayName, accountSettingsPageRoute),
//  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
//];
//
/////SA Menu Item
//List<MenuItem> saSideMenuItemRoutes = [
//  MenuItem(overviewPageDisplayName, overviewPageRoute),
//  MenuItem(schoolPageDisplayName, schoolPageRoute),
//  MenuItem(districtsPageDisplayName, districtsPageRoute),
//  MenuItem(regionPageDisplayName, regionPageRoute),
//  MenuItem(accountSettingsPageDisplayName, accountSettingsPageRoute),
//  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
//];
