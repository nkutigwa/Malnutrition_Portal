import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  final int noOfUnderweight;

  final int noOfNormal;

  final int noOfOverweight;

  final int noOfObese;

  OverviewCardsSmallScreen(
      {Key key,
      this.noOfUnderweight,
      this.noOfNormal,
      this.noOfOverweight,
      this.noOfObese})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "No. of Underweight Students",
            value: noOfUnderweight.toString() ?? "Empty",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "No of Normal Students",
            value: noOfNormal.toString() ?? "Empty",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "No. of Overweight students",
            value: noOfOverweight.toString() ?? "Empty",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "No. of Obese Students",
            value: noOfObese.toString() ?? "Empty",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
