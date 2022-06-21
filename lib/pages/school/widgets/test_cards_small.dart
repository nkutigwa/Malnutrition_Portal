import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card_small.dart';

class TestCardsSmall extends StatelessWidget {
  final int noOfUnderweight;

  final int noOfNormal;

  final int noOfOverweight;

  final int noOfObese;

  TestCardsSmall(
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
            value: noOfUnderweight.toString() ?? "0",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "No of Normal Students",
            value: noOfNormal.toString() ?? "0",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "No. of Overweight students",
            value: noOfOverweight.toString() ?? "0",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "No. of Obese Students",
            value: noOfObese.toString() ?? "0",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
