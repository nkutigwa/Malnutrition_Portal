//import 'dart:convert';
//import 'dart:io';
//import 'dart:typed_data';
//import 'dart:async';
//import 'dart:ui' as ui;
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
//import 'package:screenshot/screenshot.dart';
import 'package:printing/printing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
//import 'package:flutter_web_dashboard/pages/overview/widgets/available_drivers_table.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/bar_chart_section_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/bar_chart_section_small.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/overview_cards_small.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/revenue_section_large.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'widgets/revenue_section_small.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  ///
//  Future getPdf(Uint8List screenShot) async {
//    pw.Document pdf = pw.Document();
//    pdf.addPage(
//      pw.Page(
//        pageFormat: PdfPageFormat.a4,
//        build: (context) {
//          return pw.Expanded(
//              child: pw.Image(PdfImage.file(pdf.document, bytes: screenShot),
//                  fit: pw.BoxFit.contain));
//        },
//      ),
//    );
//    File pdfFile = File('Your path + File name');
//    pdfFile.writeAsBytesSync(pdf.save());
//  }

  ///
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _printKeyy = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _printKeyyy = GlobalKey();

////      final font = new PdfFont.helvetica(pdf);
//
//      PdfImage image = new PdfImage(pdf, image: img, width: 75, height: 100);
//      g.drawImage(image, 0.0, 0.0);
//      Printing.layoutPdf(onLayout: (format) => _getWidgetImage());
//    });
//  }

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
                    child: pw.Text(
                        "School-aged children & Adolescents BMI's Data",
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

  @override
  Widget build(BuildContext context) {
//    ///First Way
//    final Stream<QuerySnapshot> _dataStream =
//        FirebaseFirestore.instance.collection('districts').snapshots();

    ///Second Way
    final Stream<QuerySnapshot> _stream =
        FirebaseFirestore.instance.collection('docs').snapshots();

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
    int nineteenObese = 0; //from 15 to 19 and Obese

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

//              ///Total Number of Males and Females
//              if (data['gender'] == 'Male') {
//                ///If male
//                totalNoOfMaleStudents = totalNoOfMaleStudents + 1;
//                if (data['bmi_detail'] == "underweight") {
//                  maleUnderweight = maleUnderweight + 1;
//                  noOfUnderweight = noOfUnderweight + 1;
//                } else if (data['bmi_detail'] == "normal") {
//                  maleNormal = maleNormal + 1;
//                  noOfNormal = noOfNormal + 1;
//                } else if (data['bmi_detail'] == "overweight") {
//                  maleOverweight = maleOverweight + 1;
//                  noOfOverweight = noOfOverweight + 1;
//                } else {
//                  maleObese = maleObese + 1;
//                  noOfObese = noOfObese + 1;
//                }
//              } else {
//                ///If Female
//                totalNoOfFemaleStudents = totalNoOfFemaleStudents + 1;
//                if (data['bmi_detail'] == "underweight") {
//                  femaleUnderweight = femaleUnderweight + 1;
//                  noOfUnderweight = noOfUnderweight + 1;
//                } else if (data['bmi_detail'] == "normal") {
//                  femaleNormal = femaleNormal + 1;
//                  noOfNormal = noOfNormal + 1;
//                } else if (data['bmi_detail'] == "overweight") {
//                  femaleOverweight = femaleOverweight + 1;
//                  noOfOverweight = noOfOverweight + 1;
//                } else {
//                  femaleObese = femaleObese + 1;
//                  noOfObese = noOfObese + 1;
//                }
//              }
//
//              ///BMI grouped by Age
//              if (0 <= data['age'] &&  data['age'] <= 9){
//                              if (data['bmi_detail'] == "underweight")
//                nineUnderweight = nineUnderweight + 1;
//              else if (data['bmi_detail'] == "normal")
//                                nineNormal = nineNormal + 1;
//              else if (data['bmi_detail'] == "overweight")
//                                nineOverweight = nineOverweight + 1;
//              else
//                                nineObese = nineObese + 1;
//              } else if (9 < data['age'] &&  data['age'] <= 14){
//                if (data['bmi_detail'] == "underweight")
//                  fourteenUnderweight = fourteenUnderweight + 1;
//                else if (data['bmi_detail'] == "normal")
//                  fourteenNormal = fourteenNormal + 1;
//                else if (data['bmi_detail'] == "overweight")
//                  fourteenOverweight = fourteenOverweight + 1;
//                else
//                  fourteenObese = fourteenObese + 1;
//              }
//              else if (14 < data['age'] &&  data['age'] <= 19){
//
//              }
//              else{
//                //He is Above 19
//              }
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
          return Container(
            child: Column(
              children: [
//          Obx(
//            () =>
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6),
                        padding: EdgeInsets.only(top: 18.0),
                        child: CustomText(
//                    text: menuController.activeItem.value,
                          text:
                              "BMI Status For School-aged children and Adolescents (5-19 ages)",
                          size: 24,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
//          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 2.0,
                    ),
                    Container(
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
                                  context)) if (ResponsiveWidget.isCustomSize(
                              context))
                            print("Small Screen");
                          else
                            _printScreen();
                        },
                      ),
                    ),
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
                        RepaintBoundary(
                            key: _printKey,
                            child: OverviewCardsLargeScreen(
                              noOfUnderweight: noOfUnderweight,
                              noOfNormal: noOfNormal,
                              noOfOverweight: noOfOverweight,
                              noOfObese: noOfObese,
                            ))
                    else
                      OverviewCardsSmallScreen(
                        noOfUnderweight: noOfUnderweight,
                        noOfNormal: noOfNormal,
                        noOfOverweight: noOfOverweight,
                        noOfObese: noOfObese,
                      ),
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
                            totalNoOfFemaleStudents: totalNoOfFemaleStudents,
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

//                    AvailableDriversTable(),
                  ],
                ))
              ],
            ),
          );
        });
  }
}
