import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/main.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/bar_chart_section_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/bar_chart_section_small.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/revenue_section_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/revenue_section_small.dart';
import 'package:flutter_web_dashboard/pages/school/widgets/data_notifier.dart';
import 'package:flutter_web_dashboard/pages/school/widgets/list_of_schools.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'widgets/test_cards_large.dart';
import 'widgets/test_cards_medium.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'widgets/bar_chart_section_large_test.dart';
import 'widgets/bar_chart_section_small_test.dart';
import 'widgets/info_section_large.dart';
import 'widgets/info_section_small.dart';
import 'widgets/test_cards_small.dart';

class SchoolPage extends StatefulWidget {
  final bool showFullData;
  final String schoolName;
  SchoolPage({Key key, this.showFullData = false, this.schoolName})
      : super(key: key);
  @override
  _SchoolPageState createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  /// For Pdf
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _printKeyy = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _printKeyyy = GlobalKey();

  bool showFullSchoolData = false;
  String selectedSchool = MyAppState.currentUser.schoolName ?? "Mapambano";

  ///Pdf print method
  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
//        height: 400,
      );
      final imagey = await WidgetWraper.fromKey(
        key: _printKeyy,
        pixelRatio: 2.0,
//        height: 400,
      );
      final imageyy = await WidgetWraper.fromKey(
        key: _printKeyyy,
        pixelRatio: 2.0,
//        height: 400,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Container(
              child: pw.Expanded(
                child: pw.Column(children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20.0),
                    child: pw.Text("School-aged children BMI's Data",
                        style: pw.TextStyle(fontSize: 24.0)),
                  ),
                  pw.Container(
                    height: 400,
                    child: pw.Image(image),
                  ),
                  pw.Container(
                    height: 400,
                    child: pw.Image(imagey),
                  ),
                  pw.Container(
                    height: 400,
                    child: pw.Image(imageyy),
                  ),
                ]),
              ),
            );
          }));

      return doc.save();
    });
  }

  //from 15 to 19 and Obese

  @override
  Widget build(BuildContext context) {
    int noOfUnderweight = 0;

    int noOfNormal = 0;

    int noOfOverweight = 0;

    int noOfObese = 0;
    int totalNoOfSchools = 0;

    int totalNoOfStudents = 0;

    int totalNoOfMaleStudents = 0;

    int totalNoOfFemaleStudents = 0;
    int maleOverweight = 0;
    int maleUnderweight = 0;
    int maleNormal = 0;
    int maleObese = 0;
    int femaleOverweight = 0;
    int femaleUnderweight = 0;
    int femaleNormal = 0;
    int femaleObese = 0;

    int nineOverweight = 0; //from the age 9 and Below Overweight
    int nineUnderweight = 0; //9 and Below and Underweight
    int nineNormal = 0; //9 and Below and Normal
    int nineObese = 0; //9 and Below and Obese
    int fourteenOverweight = 0; //from 10 to 14 and Overweight
    int fourteenUnderweight = 0; //from 10 to 14 and Underweight
    int fourteenNormal = 0; //from 10 to 14 and Normal
    int fourteenObese = 0; //from 10 to 14 and Obese
    int nineteenOverweight = 0; //from 15 to 19 and Overweight
    int nineteenUnderweight = 0; //from 15 to 19 and Underweight
    int nineteenNormal = 0; //from 15 to 19 and Normal
    int nineteenObese = 0;

    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('docs')
        .where("school_name", isEqualTo: widget.schoolName ?? selectedSchool)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return PageNotFound(errorMessage: snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<QueryDocumentSnapshot> docs = snapshot.data.docs;

          LinkedHashSet schools = new LinkedHashSet(); //Set of Schools
          LinkedHashSet regions = new LinkedHashSet(); //Set of Regions
          LinkedHashSet districts = new LinkedHashSet(); //Set of Districts

          totalNoOfStudents = docs.length;
          for (var doc in docs) {
            if (doc.data() != null) {
              var data = doc.data() as Map<String, dynamic>;

              ///Aggregate BMI Data
              if (data['bmi_detail'] == "underweight") {
                ///Underweight
                noOfUnderweight = noOfUnderweight + 1;
                //Check Gender
                if (data['gender'] == 'Male') {
                  totalNoOfMaleStudents = totalNoOfMaleStudents + 1;
                  maleUnderweight = maleUnderweight + 1;
                } else {
                  totalNoOfFemaleStudents = totalNoOfFemaleStudents + 1;
                  femaleUnderweight = femaleUnderweight + 1;
                }
                //Check Age
                if (0 <= data['age'] && data['age'] <= 9)
                  nineUnderweight = nineUnderweight + 1;
                else if (9 < data['age'] && data['age'] <= 14)
                  fourteenUnderweight = fourteenUnderweight + 1;
                else if (14 < data['age'] && data['age'] <= 19)
                  nineteenUnderweight = nineteenUnderweight + 1;
                else {/*He is Above 19*/}
              } else if (data['bmi_detail'] == "normal") {
                ///Normal
                noOfNormal = noOfNormal + 1;
                //Check Gender
                if (data['gender'] == 'Male') {
                  totalNoOfMaleStudents = totalNoOfMaleStudents + 1;
                  maleNormal = maleNormal + 1;
                } else {
                  totalNoOfFemaleStudents = totalNoOfFemaleStudents + 1;
                  femaleNormal = femaleNormal + 1;
                }
                //Check Age
                if (0 <= data['age'] && data['age'] <= 9)
                  nineNormal = nineNormal + 1;
                else if (9 < data['age'] && data['age'] <= 14)
                  fourteenNormal = fourteenNormal + 1;
                else if (14 < data['age'] && data['age'] <= 19)
                  nineteenNormal = nineteenNormal + 1;
                else {/*He is Above 19*/}
              } else if (data['bmi_detail'] == "overweight") {
                ///Overweight
                noOfOverweight = noOfOverweight + 1;
                //Check Gender
                if (data['gender'] == 'Male') {
                  totalNoOfMaleStudents = totalNoOfMaleStudents + 1;
                  maleOverweight = maleOverweight + 1;
                } else {
                  totalNoOfFemaleStudents = totalNoOfFemaleStudents + 1;
                  femaleOverweight = femaleOverweight + 1;
                }
                //Check Age
                if (0 <= data['age'] && data['age'] <= 9)
                  nineOverweight = nineOverweight + 1;
                else if (9 < data['age'] && data['age'] <= 14)
                  fourteenOverweight = fourteenOverweight + 1;
                else if (14 < data['age'] && data['age'] <= 19)
                  nineteenOverweight = nineteenOverweight + 1;
                else {/*He is Above 19*/}
              } else {
                ///Obese
                noOfObese = noOfObese + 1;
                //Check Gender
                if (data['gender'] == 'Male') {
                  totalNoOfMaleStudents = totalNoOfMaleStudents + 1;
                  maleObese = maleObese + 1;
                } else {
                  totalNoOfFemaleStudents = totalNoOfFemaleStudents + 1;
                  femaleObese = femaleObese + 1;
                }
                //Check Age
                if (0 <= data['age'] && data['age'] <= 9)
                  nineObese = nineObese + 1;
                else if (9 < data['age'] && data['age'] <= 14)
                  fourteenObese = fourteenObese + 1;
                else if (14 < data['age'] && data['age'] <= 19)
                  nineteenObese = nineteenObese + 1;
                else {/*He is Above 19*/}
              }

              ///Total No of Schools
              if (!schools.contains(data['school_name'])) {
                schools.add(data['school_name']);
                totalNoOfSchools = totalNoOfSchools + 1;
              }
            }
          }
//          return Container(
//            child: Container(
//              height: 900,
//              width: MediaQuery.of(context).size.width * 0.65,
//              child: Column(
//                children: [
//                  Obx(
//                    () => Row(
//                      children: [
//                        Container(
//                            margin: EdgeInsets.only(
//                                top: ResponsiveWidget.isSmallScreen(context)
//                                    ? 56
//                                    : 6),
//                            child: CustomText(
//                              text: menuController.activeItem.value,
//                              size: 24,
//                              weight: FontWeight.bold,
//                            )),
//                      ],
//                    ),
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      SizedBox(
//                        height: 2.0,
//                      ),
//                      Container(
//                        constraints: BoxConstraints(
//                            minWidth: 250, maxWidth: 250, minHeight: 40),
//                        margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
//                        child: FlatButton(
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.all(
//                              Radius.circular(
//                                10.0,
//                              ),
//                            ),
//                          ),
//                          color: active,
//                          child: CustomText(
//                            text: "Print PDF",
//                            color: Colors.white,
//                          ),
//                          onPressed: () {
//                            if (ResponsiveWidget.isLargeScreen(context) ||
//                                ResponsiveWidget.isMediumScreen(
//                                    context)) if (ResponsiveWidget.isCustomSize(
//                                context))
//                              print("Small Screen");
//                            else
//                              _printScreen();
//                          },
//                        ),
//                      ),
//                    ],
//                  ),
//                  Expanded(
//                      child: ListView(
//                    children: [
//                      if (ResponsiveWidget.isLargeScreen(context) ||
//                          ResponsiveWidget.isMediumScreen(context))
//                        if (ResponsiveWidget.isCustomSize(context))
//                          TestCardsMedium(
//                            noOfUnderweight: noOfUnderweight,
//                            noOfNormal: noOfNormal,
//                            noOfOverweight: noOfOverweight,
//                            noOfObese: noOfObese,
//                          )
//                        else
//                          RepaintBoundary(
//                              key: _printKey,
//                              child: TestCardsLarge(
//                                noOfUnderweight: noOfUnderweight,
//                                noOfNormal: noOfNormal,
//                                noOfOverweight: noOfOverweight,
//                                noOfObese: noOfObese,
//                              ))
//                      else
//                        TestCardsSmall(
//                          noOfUnderweight: noOfUnderweight,
//                          noOfNormal: noOfNormal,
//                          noOfOverweight: noOfOverweight,
//                          noOfObese: noOfObese,
//                        ),
//
//                      ///TODO Add Bar Chart Section
//                      if (ResponsiveWidget.isSmallScreen(context) ||
//                          ResponsiveWidget.isCustomSize(context))
//                        BarChartSmallSectionTest(
//                          MUnderweight: maleUnderweight,
//                          MNormal: maleNormal,
//                          MObese: maleObese,
//                          MOverweight: maleOverweight,
//                          FUnderweight: femaleUnderweight,
//                          FNormal: femaleNormal,
//                          FOverweight: femaleOverweight,
//                          FObese: femaleObese,
//                          nineNormal: nineNormal,
//                          nineUnderweight: nineUnderweight,
//                          nineOverweight: nineOverweight,
//                          nineObese: nineObese,
//                          fourteenUnderweight: fourteenUnderweight,
//                          fourteenNormal: fourteenNormal,
//                          fourteenOverweight: fourteenOverweight,
//                          fourteenObese: fourteenObese,
//                          nineteenUnderweight: nineteenUnderweight,
//                          nineteenNormal: nineteenNormal,
//                          nineteenOverweight: nineteenOverweight,
//                          nineteenObese: nineteenObese,
//                        )
//                      else
//                        RepaintBoundary(
//                            key: _printKeyy,
//                            child: BarChartSectionLargeTest(
//                              MUnderweight: maleUnderweight,
//                              MNormal: maleNormal,
//                              MObese: maleObese,
//                              MOverweight: maleOverweight,
//                              FUnderweight: femaleUnderweight,
//                              FNormal: femaleNormal,
//                              FOverweight: femaleOverweight,
//                              FObese: femaleObese,
//                              nineNormal: nineNormal,
//                              nineUnderweight: nineUnderweight,
//                              nineOverweight: nineOverweight,
//                              nineObese: nineObese,
//                              fourteenUnderweight: fourteenUnderweight,
//                              fourteenNormal: fourteenNormal,
//                              fourteenOverweight: fourteenOverweight,
//                              fourteenObese: fourteenObese,
//                              nineteenUnderweight: nineteenUnderweight,
//                              nineteenNormal: nineteenNormal,
//                              nineteenOverweight: nineteenOverweight,
//                              nineteenObese: nineteenObese,
//                            )),
//                      if (!ResponsiveWidget.isSmallScreen(context))
//                        RepaintBoundary(
//                            key: _printKeyyy,
//                            child: InfoSectionLarge(
//                              noOfUnderweight: noOfUnderweight,
//                              noOfNormal: noOfNormal,
//                              noOfOverweight: noOfOverweight,
//                              noOfObese: noOfObese,
//                              totalNoOfSchools: totalNoOfSchools,
//                              totalNoOfStudents: totalNoOfStudents,
//                              totalNoOfFemaleStudents: totalNoOfFemaleStudents,
//                              totalNoOfMaleStudents: totalNoOfMaleStudents,
//                            ))
//                      else
//                        InfoSectionSmall(
//                          noOfUnderweight: noOfUnderweight,
//                          noOfNormal: noOfNormal,
//                          noOfOverweight: noOfOverweight,
//                          noOfObese: noOfObese,
//                          totalNoOfSchools: totalNoOfSchools,
//                          totalNoOfStudents: totalNoOfStudents,
//                          totalNoOfFemaleStudents: totalNoOfFemaleStudents,
//                          totalNoOfMaleStudents: totalNoOfMaleStudents,
//                        ),
////                  AvailableDriversTable(),
//                    ],
//                  ))
//                ],
//              ),
//            ),
//          );
          return ChangeNotifierProvider<SchoolDataNotifier>(
            create: (_) => SchoolDataNotifier(),
            child: Container(
              child: Column(
                children: [
//                  Obx(
//                    () =>
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: ResponsiveWidget.isSmallScreen(context)
                                  ? 56
                                  : 6),
                          child: CustomText(
                            text: selectedSchool + "\'s Data",
                            size: 26,
                            color: active,
                            weight: FontWeight.bold,
                          )),
                    ],
                  ),
//                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 2.0,
                      ),
                      showFullSchoolData
                          ? Container(
                              constraints: BoxConstraints(
                                  minWidth: 250, maxWidth: 250, minHeight: 40),
                              margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
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
                                  text: "Print PDF",
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (ResponsiveWidget.isLargeScreen(context) ||
                                      ResponsiveWidget.isMediumScreen(
                                          context)) if (ResponsiveWidget
                                      .isCustomSize(context))
                                    print("Small Screen");
                                  else
                                    _printScreen();
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      if (ResponsiveWidget.isLargeScreen(context) ||
                          ResponsiveWidget.isMediumScreen(context))
                        if (ResponsiveWidget.isCustomSize(context))
                          OverviewCardsMediumScreen(
                            noOfUnderweight: noOfUnderweight,
                            noOfNormal: noOfNormal,
                            noOfOverweight: noOfOverweight,
                            noOfObese: noOfObese,
                          )
                        else
                          OverviewCardsLargeScreen(
                            noOfUnderweight: noOfUnderweight,
                            noOfNormal: noOfNormal,
                            noOfOverweight: noOfOverweight,
                            noOfObese: noOfObese,
                          )
                      else
                        OverviewCardsSmallScreen(
                          noOfUnderweight: noOfUnderweight,
                          noOfNormal: noOfNormal,
                          noOfOverweight: noOfOverweight,
                          noOfObese: noOfObese,
                        ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showFullSchoolData = !showFullSchoolData;
                          });
                        },
                        child: Text(
                          showFullSchoolData
                              ? 'Show List of Other Schools'
                              : 'See school\'s full data',
                          style: TextStyle(
                            color: active,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if (widget.showFullData || showFullSchoolData)
                        if (!ResponsiveWidget.isSmallScreen(context))
                          RepaintBoundary(
                              key: _printKeyy,
                              child: RevenueSectionLarge(
                                noOfUnderweight: noOfUnderweight,
                                noOfNormal: noOfNormal,
                                noOfOverweight: noOfOverweight,
                                noOfObese: noOfObese,
                                totalNoOfSchools: totalNoOfSchools,
                                totalNoOfStudents: totalNoOfStudents,
                                totalNoOfFemaleStudents:
                                    totalNoOfFemaleStudents,
                                totalNoOfMaleStudents: totalNoOfMaleStudents,
                              ))
                        else
                          RevenueSectionSmall(
                            noOfUnderweight: noOfUnderweight,
                            noOfNormal: noOfNormal,
                            noOfOverweight: noOfOverweight,
                            noOfObese: noOfObese,
                            totalNoOfSchools: totalNoOfSchools,
                            totalNoOfStudents: totalNoOfStudents,
                            totalNoOfFemaleStudents: totalNoOfFemaleStudents,
                            totalNoOfMaleStudents: totalNoOfMaleStudents,
                          ),

                      ///TODO Add Bar Chart Section
                      if (widget.showFullData || showFullSchoolData)
                        if (ResponsiveWidget.isSmallScreen(context) ||
                            ResponsiveWidget.isCustomSize(context))
                          BarChartSmallSection(
                            MUnderweight: maleUnderweight,
                            MNormal: maleNormal,
                            MObese: maleObese,
                            MOverweight: maleOverweight,
                            FUnderweight: femaleUnderweight,
                            FNormal: femaleNormal,
                            FOverweight: femaleOverweight,
                            FObese: femaleObese,
                            nineNormal: nineNormal,
                            nineUnderweight: nineUnderweight,
                            nineOverweight: nineOverweight,
                            nineObese: nineObese,
                            fourteenUnderweight: fourteenUnderweight,
                            fourteenNormal: fourteenNormal,
                            fourteenOverweight: fourteenOverweight,
                            fourteenObese: fourteenObese,
                            nineteenUnderweight: nineteenUnderweight,
                            nineteenNormal: nineteenNormal,
                            nineteenOverweight: nineteenOverweight,
                            nineteenObese: nineteenObese,
                          )
                        else
                          RepaintBoundary(
                              key: _printKeyyy,
                              child: BarChartSectionLarge(
                                MUnderweight: maleUnderweight,
                                MNormal: maleNormal,
                                MObese: maleObese,
                                MOverweight: maleOverweight,
                                FUnderweight: femaleUnderweight,
                                FNormal: femaleNormal,
                                FOverweight: femaleOverweight,
                                FObese: femaleObese,
                                nineNormal: nineNormal,
                                nineUnderweight: nineUnderweight,
                                nineOverweight: nineOverweight,
                                nineObese: nineObese,
                                fourteenUnderweight: fourteenUnderweight,
                                fourteenNormal: fourteenNormal,
                                fourteenOverweight: fourteenOverweight,
                                fourteenObese: fourteenObese,
                                nineteenUnderweight: nineteenUnderweight,
                                nineteenNormal: nineteenNormal,
                                nineteenOverweight: nineteenOverweight,
                                nineteenObese: nineteenObese,
                              )),
                      showFullSchoolData
                          ? Container()
                          : ListOfSchools(
                              onRowSelected: (value) {
                                setState(() {
                                  selectedSchool = value.toString();
                                });
                              },
                            ),
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }
}
