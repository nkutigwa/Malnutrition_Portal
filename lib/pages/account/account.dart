import 'dart:convert';
import 'dart:io';
//import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/authenticate.dart';
import 'package:flutter_web_dashboard/helpers/helper.dart';
import 'package:flutter_web_dashboard/helpers/search.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:flutter_web_dashboard/pages/signUp/choose_role_page.dart';
//import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:flutter_web_dashboard/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
//import 'package:get/get.dart';

import '../../main.dart';
//import 'package:get/get.dart';

File _image;

class AccountPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String gender;
  final String birthDate;
  final String phoneNumber;
  final String email;
  final String district;
  final String region;
  final Function onChangedFirstName;
  final Function onChangedLastName;
  final Function onChangedGender;
  final Function onChangedBirthDate;
  final Function onChangedPhoneNumber;
  final Function onChangedEmail;
  final Function onTapBirthDate;

  AccountPage({
    Key key,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthDate,
    this.phoneNumber,
    this.email,
    this.onChangedFirstName,
    this.onChangedLastName,
    this.onChangedGender,
    this.onChangedBirthDate,
    this.onChangedPhoneNumber,
    this.onChangedEmail,
    this.onTapBirthDate,
    this.district,
    this.region,
  }) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      width: MediaQuery.of(context).size.width * 0.8,
//      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 60),
//      constraints: BoxConstraints(
//        maxWidth: double.infinity,
//        maxHeight: MediaQuery.of(context).size.height * 0.8,
//      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: PersonalInformationPage(),
          ),
        ],
      ),
    );
  }
}

class PersonalInformationPage extends StatefulWidget {
//  final String firstName;
//  final String lastName;
//  final String gender;
//  final String birthDate;
//  final String phoneNumber;
//  final String email;
//  final String region;
//  final String district;
//  final Function onChangedFirstName;
//  final Function onChangedLastName;
//  final Function onChangedGender;
//  final Function onChangedBirthDate;
//  final Function onChangedPhoneNumber;
//  final Function onChangedEmail;
//  final Function onChangedDistrict;
//  final Function onChangedRegion;
//  final Function onTapBirthDate;

  PersonalInformationPage({
    Key key,

//      this.firstName,
//      this.lastName,
//      this.gender,
//      this.birthDate,
//      this.phoneNumber,
//      this.email,
//      this.onChangedFirstName,
//      this.onChangedLastName,
//      this.onChangedGender,
//      this.onChangedBirthDate,
//      this.onChangedPhoneNumber,
//      this.onChangedEmail,
//      this.onTapBirthDate,
//      this.region,
//      this.district,
//      this.onChangedDistrict,
//      this.onChangedRegion}
  }) : super(key: key);
  @override
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  String firstName = MyAppState.currentUser.firstName;
  String lastName = MyAppState.currentUser.lastName;
  String phoneNumber = MyAppState.currentUser.phoneNumber;
  String email = MyAppState.currentUser.email;
//  String gender = MyAppState.currentUser.firstName;
//  String birthDate = MyAppState.currentUser.firstName;
//  String documentRef = MyAppState.currentUser.firstName;
  String district = MyAppState.currentUser.district;
  String region = MyAppState.currentUser.region;
  static List<String> regions = [];
  static List<String> districts = [];
  _updateUser() async {
    showProgress(context, 'Updating User', false);
    auth.User firebaseUser = auth.FirebaseAuth.instance.currentUser;
    User user = await FireStoreUtils().getCurrentUser(firebaseUser.uid);
    user.firstName = firstName;
    user.lastName = lastName;
    user.district = district.toString();
    user.region = region.toString();
    user.phoneNumber = phoneNumber;
    FireStoreUtils.updateCurrentUser(user);
    MyAppState.currentUser = user;
    hideProgress();
    navigationController.navigateTo(accountSettingsPageRoute);
  }

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
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          displayCircleImage(
              MyAppState.currentUser.profilePictureURL != null
                  ? MyAppState.currentUser.profilePictureURL
                  : "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png",
              130.0,
              true),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PersonalInfoWidget(
              label: 'First Name',
              hintText: firstName,
              onChanged: (value) {
                firstName = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PersonalInfoWidget(
              label: 'Last Name',
              hintText: lastName,
              onChanged: (value) {
                lastName = value;
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//              Container(
//                height: 100,
//                width: 130,
//                padding: const EdgeInsets.all(8.0),
//                child:
              SizedBox(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "District",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
//              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 386,
                  maxHeight: 65.0,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      autoFocusSearchBox: false,
                      showSelectedItem: true,
                      showSearchBox: true,
                      onFind: (filter) => Search.search(
                            filter,
                            districts,
                          ),
                      items: districts,
                      dropdownSearchDecoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          fillColor: Colors.white,
                          hintText: district,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: active, width: 2.0)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
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
                        setState(() {
                          district = value;
                        });

//                  print(districtName);
                      },
                      selectedItem: "District"),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//              Container(
////                  height: 20.0,
////                  width: 130,
//                padding: const EdgeInsets.all(8.0),
//                child: GestureDetector(
//                  child:
              SizedBox(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Region",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
//                ),
//              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 386,
                  maxHeight: 65.0,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      autoFocusSearchBox: false,
                      showSelectedItem: true,
                      showSearchBox: true,
                      onFind: (filter) => Search.search(
                            filter,
                            regions,
                          ),
                      items: regions,
                      dropdownSearchDecoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          fillColor: Colors.white,
                          hintText: region,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: active, width: 2.0)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
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
                        setState(() {
                          region = value;
                        });

//                        print(regionName);
                      },
                      selectedItem: "Region"),
                ),
              ),
            ],
          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: PersonalInfoWidget(
//              label: 'District',
//              hintText: widget.email,
//              onChanged: widget.onChangedEmail,
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: PersonalInfoWidget(
//              label: 'Region',
//              hintText: widget.email,
//              onChanged: widget.onChangedEmail,
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: PersonalInfoWidget(
//              label: 'Email',
//              hintText: widget.email,
//              onChanged: widget.onChangedEmail,
//            ),
//          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PersonalInfoWidget(
                label: 'Phone Number',
                hintText: phoneNumber,
                onChanged: (value) {
                  phoneNumber = value;
                }),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
              ),
              ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: 370, maxWidth: 370, minHeight: 40),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  color: active,
                  child: CustomText(
                    text: "Update",
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    ///TODO Update User Info
                    await _updateUser();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                navigationController.navigateTo(resetPasswordPageRoute);
              });
            },
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: "Worried about security? "),
              TextSpan(
                  text: "Request Password Update ",
                  style: TextStyle(color: active))
            ])),
          )
        ],
      ),
    );
  }
}

class PersonalInfoWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData leading;
  final Function onChanged;
  final Function onTap;
  final Function onTapLabel;
  final bool obscure;
  final TextInputType keyboard;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final FocusNode focusNode;

  PersonalInfoWidget(
      {Key key,
      this.hintText,
      this.leading,
      this.onChanged,
      this.obscure,
      this.keyboard,
      this.validator,
      this.controller,
      this.focusNode,
      this.label,
      this.onTap,
      this.onTapLabel});
  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 130,
//      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
//            height: 130,
            width: 130,
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: onTapLabel,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          Container(
            child: CustomTextField(
              onChanged: onChanged,
              hintText: hintText,
              labelText: label,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}

class GenderWidget extends StatefulWidget {
  final String initialGenderValue;
  final Function onChanged;
  GenderWidget({Key key, @required this.initialGenderValue, this.onChanged})
      : super(key: key);
  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  String genderValue = "Select One";

//  String dropdownFilter = 'Short by: Price';
  @override
  void initState() {
    // TODO: implement initState
    genderValue = widget.initialGenderValue ?? "Select One";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          DropdownButton(
            value: genderValue,
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 20.0,
            ),
            underline: Container(),
            onChanged: (value) {
              setState(() {
                genderValue = value;
                widget.onChanged(value);
              });
            },
            items: [
              "Select One",
              "Male",
              "Female",
              "Rather not say",
            ]
                .map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
