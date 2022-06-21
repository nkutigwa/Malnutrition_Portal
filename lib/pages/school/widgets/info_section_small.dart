import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
//import 'package:flutter_web_dashboard/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/pie_chart.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/revenue_info.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';

class InfoSectionSmall extends StatelessWidget {
  final int totalNoOfSchools;

  final int totalNoOfStudents;

  final int totalNoOfMaleStudents;

  final int totalNoOfFemaleStudents;

  final int noOfUnderweight;

  final int noOfNormal;

  final int noOfOverweight;

  final int noOfObese;

  InfoSectionSmall(
      {Key key,
      this.totalNoOfSchools,
      this.totalNoOfStudents,
      this.totalNoOfMaleStudents,
      this.totalNoOfFemaleStudents,
      this.noOfUnderweight,
      this.noOfNormal,
      this.noOfOverweight,
      this.noOfObese})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
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
      child: Column(
        children: [
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "BMI chart status",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                Container(
                    width: 600,
                    height: 200,
//                    child: SimpleBarChart.withSampleData()),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 2,
                            child: DonutPieChart.withSampleData(
                              underWeight: noOfUnderweight ?? 0,
                              normal: noOfNormal ?? 0,
                              overWeight: noOfOverweight ?? 0,
                              obese: noOfObese ?? 0,
                            )),
                        Flexible(
                          flex: 2,
                          child: DetailsColumn(),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(
                      title: "Total No. of Students",
                      amount: totalNoOfStudents.toString(),
                    ),
                    RevenueInfo(
                      title: "Total No. of Schools",
                      amount: totalNoOfSchools.toString(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RevenueInfo(
                      title: "Male Students",
                      amount: totalNoOfMaleStudents.toString(),
                    ),
                    RevenueInfo(
                      title: "Female Students",
                      amount: totalNoOfFemaleStudents.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
