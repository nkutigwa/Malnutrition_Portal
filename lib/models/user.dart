import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String firstName;
  String lastName;

  String phoneNumber;

  bool active;

  Timestamp lastOnlineTimestamp;

  String userID;
  String profilePictureURL;
  String schoolName;
  String district;
  String region;
  String role;

  bool selected;

//  String appIdentifier;

  User({
    this.email = '',
    this.firstName = '',
    this.phoneNumber = '',
    this.lastName = '',
    this.active = false,
    this.selected = false,
    lastOnlineTimestamp,
    this.userID = '',
    this.profilePictureURL = '',
    this.schoolName = '',
    this.district = '',
    this.region = '',
    this.role = 'DNO',
  });
//      : this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now()};
//        this.appIdentifier = 'Flutter Login Screen ${Platform.operatingSystem}';

  String fullName() {
    return '$firstName $lastName';
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        email: parsedJson['email'] ?? '',
        firstName: parsedJson['firstName'] ?? '',
        lastName: parsedJson['lastName'] ?? '',

        ///Added
        schoolName: parsedJson['schoolName'] ?? '',
        district: parsedJson['district'] ?? '',
        region: parsedJson['region'] ?? '',
        role: parsedJson['role'] ?? '',

        ///
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'],
        phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'firstName': this.firstName,
      'lastName': this.lastName,

      ///Added
      'schoolName': this.schoolName,
      'district': this.district,
      'region': this.region,
      'role': this.role,

      ///
      'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      'profilePictureURL': this.profilePictureURL,
//      'appIdentifier': this.appIdentifier
    };
  }
}
