import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  final int noOfUnderweight;

  final int noOfNormal;

  final int noOfOverweight;

  final int noOfObese;

  OverviewCardsLargeScreen(
      {Key key,
      this.noOfUnderweight,
      this.noOfNormal,
      this.noOfOverweight,
      this.noOfObese})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          title: "No. of Underweight Students",
          value: noOfUnderweight.toString() ?? "Empty",
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "No. of Normal Students",
          value: noOfNormal.toString() ?? "Empty",
          topColor: Colors.lightGreen,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "No. of Overweight Students",
          value: noOfOverweight.toString() ?? "Empty",
          topColor: Colors.orange,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "No. of Obese Students",
          value: noOfObese.toString() ?? "Empty",
          topColor: Colors.redAccent,
          onTap: () {},
        ),
      ],
    );
  }
}

///Firebase Demo
//            if (doc.data() != null) {
//              var data = doc.data() as Map<String, dynamic>;
////              var name = data['name']; // You can get other data in this manner.
//
//              if (data['bmi_detail'].toString() == 'Normal') {
//                noOfNormal = noOfNormal + 1;
//              } else if (data['bmi_detail'].toString() == 'Overweight') {
//                noOfOverweight = noOfOverweight + 1;
//              } else if (data['bmi_detail'].toString() == 'Obese') {
//                noOfObese = noOfObese + 1;
//              } else if (data['bmi_detail'].toString() == 'Underweight') {
//                noOfUnderweight = noOfUnderweight + 1;
//              }
//            }

//class Data {
//  static Stream<List<Student>> getStudentStream(String schoolName) {
//    List<Student> stds = [];
//    FirebaseFirestore.instance
//        .collection(schoolName)
//        .doc('properties')
//        .collection('students')
//        .get()
//        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//      final students = querySnapshot.docs;
//      for (var student in students) {
//        Student std = Student(
//          name: student.data()['fullName'],
//          age: student.data()['age'],
//          gender: student.data()['gender'],
//          bmiStatus: student.data()['bmiStatus'],
////          grade: student.data()['grade'],
////          bmi: student.data()['bmi'],
//        );
//        stds.add(std);
//      }
//      print(stds);
//    });
//
//    return Stream.value(stds);
//  }
//
//  static List<Student> getStudentList(String schoolName) {
//    List<Student> stds = [];
//    FirebaseFirestore.instance
//        .collection(schoolName)
//        .doc('properties')
//        .collection('students')
//        .get()
//        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//      final students = querySnapshot.docs;
//      for (var student in students) {
//        Student std = Student(
//          name: student.data()['fullName'],
//          age: student.data()['age'],
//          gender: student.data()['gender'],
//          bmiStatus: student.data()['bmiStatus'],
////          grade: student.data()['grade'],
////          bmi: student.data()['bmi'],
//        );
//        stds.add(std);
//      }
//      print(stds);
//    });
//    return stds;
//  }
//}

///
///Number of Underweight
//Future<int> noOfUnderWeight(List<String> schools) async {
//  int noOfUnderWeight = 0;
//  for (int i = 0; i <= schools.length; i++) {
//    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//        .instance
//        .collection('schools')
//        .doc(schools[i].toString())
//        .collection("students")
//        .where('bmi_detail', isEqualTo: "Underweight")
//        .get();
//    noOfUnderWeight = noOfUnderWeight + snapshot.docs.length.toInt();
//  }
//  return noOfUnderWeight;
//}
//
//Future<int> noOfOverWeight(List<String> schools) async {
//  int noOfOverWeight = 0;
//  for (int i = 0; i <= schools.length; i++) {
//    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//        .instance
//        .collection('schools')
//        .doc(schools[i].toString())
//        .collection("students")
//        .where('bmi_detail', isEqualTo: "Overweight")
//        .get();
//    noOfOverWeight = noOfOverWeight + snapshot.docs.length.toInt();
//  }
//  return noOfOverWeight;
//}
//
//Future<int> noNormal(List<String> schools) async {
//  int noNormal = 0;
//  for (int i = 0; i <= schools.length; i++) {
//    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//        .instance
//        .collection('schools')
//        .doc(schools[i].toString())
//        .collection("students")
//        .where('bmi_detail', isEqualTo: "Normal")
//        .get();
//    noNormal = noNormal + snapshot.docs.length.toInt();
//    print(noNormal);
//  }
//  return noNormal;
//}
//
//Future<int> noObese(List<String> schools) async {
//  int noObese = 0;
//  for (int i = 0; i <= schools.length; i++) {
//    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//        .instance
//        .collection('schools')
//        .doc(schools[i].toString())
//        .collection("students")
//        .where('bmi_detail', isEqualTo: "Obese")
//        .get();
//    noObese = noObese + snapshot.docs.length.toInt();
//  }
//  return noObese;
//}
//
//Future noOf(List<String> schools) async {
//  Map<int, int> map;
//  noOfUnderweight =
//  await noOfUnderWeight(schools).then((value) => map[1] = value);
//  noOfOverweight =
//  await noOfOverWeight(schools).then((value) => map[2] = value);
//  noOfNormal = await noNormal(schools).then((value) => map[3] = value);
//  noOfObese = await noObese(schools).then((value) => map[1] = value);
//}
