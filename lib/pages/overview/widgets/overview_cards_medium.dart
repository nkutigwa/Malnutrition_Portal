import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  final int noOfUnderweight;

  final int noOfNormal;

  final int noOfOverweight;

  final int noOfObese;
  OverviewCardsMediumScreen(
      {Key key,
      this.noOfUnderweight,
      this.noOfNormal,
      this.noOfOverweight,
      this.noOfObese})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "No. of Underweight Students",
              value: noOfUnderweight.toString() ?? "Empty",
              onTap: () {},
              topColor: Colors.orange,
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
          ],
        ),
        SizedBox(
          height: _width / 64,
        ),
        Row(
          children: [
            InfoCard(
              title: "No. of Overweight students",
              value: noOfOverweight.toString() ?? "Empty",
              topColor: Colors.redAccent,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "No. of Obese Students",
              value: noOfObese.toString() ?? "Empty",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
