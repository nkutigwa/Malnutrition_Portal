import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/widgets/age_group_card.dart';
import 'package:flutter_web_dashboard/widgets/gender_group_card.dart';

class BarChartSmallSectionTest extends StatelessWidget {
  final int MOverweight;
  final int MUnderweight;
  final int MNormal;
  final int MObese;
  final int FOverweight;
  final int FUnderweight;
  final int FNormal;
  final int FObese;
  final int nineOverweight;
  final int nineUnderweight;
  final int nineNormal;
  final int nineObese;
  final int fourteenOverweight;
  final int fourteenUnderweight;
  final int fourteenNormal;
  final int fourteenObese;
  final int nineteenOverweight;
  final int nineteenUnderweight;
  final int nineteenNormal;
  final int nineteenObese;

  BarChartSmallSectionTest(
      {Key key,
      this.MOverweight,
      this.MUnderweight,
      this.MNormal,
      this.MObese,
      this.FOverweight,
      this.FUnderweight,
      this.FNormal,
      this.FObese,
      this.nineOverweight,
      this.nineUnderweight,
      this.nineNormal,
      this.nineObese,
      this.fourteenOverweight,
      this.fourteenUnderweight,
      this.fourteenNormal,
      this.fourteenObese,
      this.nineteenOverweight,
      this.nineteenUnderweight,
      this.nineteenNormal,
      this.nineteenObese})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: GenderCard(
              MUnderweight: MUnderweight,
              MNormal: MNormal,
              MObese: MObese,
              MOverweight: MOverweight,
              FUnderweight: FUnderweight,
              FNormal: FNormal,
              FOverweight: FOverweight,
              FObese: FObese,
            ),
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: AgeGroupCard(
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
            ),
          ),
        ],
      ),
    );
  }
}
