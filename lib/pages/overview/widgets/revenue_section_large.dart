import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/pie_chart.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/revenue_info.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';

class RevenueSectionLarge extends StatelessWidget {
  final int totalNoOfSchools;

  final int totalNoOfStudents;

  final int totalNoOfMaleStudents;

  final int totalNoOfFemaleStudents;

  final int noOfUnderweight;

  final int noOfNormal;

  final int noOfOverweight;

  final int noOfObese;

  RevenueSectionLarge(
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
//    return StreamBuilder<QuerySnapshot>(
//        stream: _stream,
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) {
//            return PageNotFound();
//          }
//
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Text("Loading");
//          }
//
//          List<QueryDocumentSnapshot> docs = snapshot.data.docs;
//
//          LinkedHashSet set1 = new LinkedHashSet();
//          totalNoOfStudents = docs.length;
//          for (var doc in docs) {
//            if (doc.data() != null) {
//              var data = doc.data() as Map<String, dynamic>;
//
//              if (data['gender'] == 'Male')
//                totalNoOfMaleStudents = totalNoOfMaleStudents + 1;
//              else
//                totalNoOfFemaleStudents = totalNoOfFemaleStudents + 1;
//
//              ///Aggregate Data
//              if (data['bmi_detail'] == "underweight")
//                noOfUnderweight = noOfUnderweight + 1;
//              else if (data['bmi_detail'] == "normal")
//                noOfNormal = noOfNormal + 1;
//              else if (data['bmi_detail'] == "overweight")
//                noOfOverweight = noOfOverweight + 1;
//              else
//                noOfObese = noOfObese + 1;
//
//              ///Total No of Schools
//              if (!set1.contains(data['school_name'])) {
//                set1.add(data['school_name']);
//                totalNoOfSchools = totalNoOfSchools + 1;
//              }
//            }
//          }
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "BMI Chart status",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                Container(
                    width: 600,
                    height: 200,
//                           child: SimpleBarChart.withSampleData()),
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
            width: 1,
            height: 120,
            color: lightGrey,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(
                      title: "Total No. of Students",
                      amount: totalNoOfStudents.toString() ?? "Empty",
                    ),
                    RevenueInfo(
                      title: "Total No. of Schools",
                      amount: totalNoOfSchools.toString() ?? "Empty",
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    RevenueInfo(
                      title: "Male Students",
                      amount: totalNoOfMaleStudents.toString() ?? "Empty",
                    ),
                    RevenueInfo(
                      title: "Female Students",
                      amount: totalNoOfFemaleStudents.toString() ?? "Empty",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
//        });
  }
}
