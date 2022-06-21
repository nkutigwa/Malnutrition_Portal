//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';

class TestCardsLarge extends StatelessWidget {
  final int noOfUnderweight;

  final int noOfNormal;

  final int noOfOverweight;

  final int noOfObese;

  TestCardsLarge(
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
          value: noOfUnderweight.toString() ?? "0",
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "No. of Normal Students",
          value: noOfNormal.toString() ?? "0",
          topColor: Colors.lightGreen,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "No. of Overweight Students",
          value: noOfOverweight.toString() ?? "0",
          topColor: Colors.orange,
          onTap: () {},
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "No. of Obese Students",
          value: noOfObese.toString() ?? "0",
          topColor: Colors.redAccent,
          onTap: () {},
        ),
      ],
    );
  }
}

//class TestCardsLarge extends StatelessWidget {
//  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
//      .collection('schools')
//      .doc('fYavV0VoONjc6EZhCysV')
//      .collection('students')
//      .snapshots();
//
//  @override
//  Widget build(BuildContext context) {
//    double _width = MediaQuery.of(context).size.width;
//
//    ///
//    return StreamBuilder<QuerySnapshot>(
//        stream: _usersStream,
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) {
//            return Text('Something went wrong');
//          }
//
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Text("Loading");
//          }
//
//          ///Querying
//          final students = snapshot.data.docs;
//          int noOfUnderweight = 0;
//          int noOfNormal = 0;
//          int noOfOverweight = 0;
//          int noOfObese = 0;
//
//          List<QueryDocumentSnapshot> docs = snapshot.data.docs;
//          for (var doc in docs) {
//            if (doc.data() != null) {
//              var data = doc.data() as Map<String, dynamic>;
////              var name = data['name']; // You can get other data in this manner.
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
//          }
//          return Row(
//            children: [
//              InfoCard(
//                title: "No. of Underweight Students",
//                value: noOfUnderweight.toString(),
//                onTap: () {},
//              ),
//              SizedBox(
//                width: _width / 64,
//              ),
//              InfoCard(
//                title: "No. of Normal Students",
//                value: noOfNormal.toString(),
//                topColor: Colors.lightGreen,
//                onTap: () {},
//              ),
//              SizedBox(
//                width: _width / 64,
//              ),
//              InfoCard(
//                title: "No. of Overweight Students",
//                value: noOfOverweight.toString(),
//                topColor: Colors.orange,
//                onTap: () {},
//              ),
//              SizedBox(
//                width: _width / 64,
//              ),
//              InfoCard(
//                title: "No. of Obese Students",
//                value: noOfObese.toString(),
//                topColor: Colors.redAccent,
//                onTap: () {},
//              ),
//            ],
//          );
//        });
//  }
//}
