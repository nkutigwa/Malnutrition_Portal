import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_web_dashboard/constants/style.dart';

class GenderCard extends StatefulWidget {
  final int MOverweight;
  final int MUnderweight;
  final int MNormal;
  final int MObese;
  final int FOverweight;
  final int FUnderweight;
  final int FNormal;
  final int FObese;

  GenderCard(
      {this.MOverweight,
      this.MUnderweight,
      this.MNormal,
      this.MObese,
      this.FOverweight,
      this.FUnderweight,
      this.FNormal,
      this.FObese});
  @override
  _GenderCardState createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
//      height: MediaQuery.of(context).size.height * 0.4,
//      width: MediaQuery.of(context).size.width * 0.3,
      padding: EdgeInsets.all(20.0),
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 10.0,
            right: 10.0,
            bottom: 32.0,
          ),
          child: ListTile(
              title: Text(
                'Gender',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              subtitle: StackedHorizontalBarChart.withSampleData(
                MNormal: widget.MNormal,
                MObese: widget.MObese,
                MOverweight: widget.MOverweight,
                MUnderweight: widget.MUnderweight,
                FNormal: widget.FNormal,
                FObese: widget.FObese,
                FOverweight: widget.FOverweight,
                FUnderweight: widget.FUnderweight,
              )),
        ),
      ),
    );
  }
}

class StackedHorizontalBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedHorizontalBarChart(this.seriesList, {this.animate});

  /// Creates a stacked [BarChart] with sample data and no transition.
  factory StackedHorizontalBarChart.withSampleData({
    int MOverweight,
    int MUnderweight,
    int MNormal,
    int MObese,
    int FOverweight,
    int FUnderweight,
    int FNormal,
    int FObese,
  }) {
    return new StackedHorizontalBarChart(
      _createSampleData(
        MNormal: MNormal,
        MObese: MObese,
        MOverweight: MOverweight,
        MUnderweight: MUnderweight,
        FNormal: FNormal,
        FObese: FObese,
        FOverweight: FOverweight,
        FUnderweight: FUnderweight,
      ),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
      vertical: true,
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
              minimumPaddingBetweenLabelsPx: 0,
              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 16, // size in Pts.
                  color: charts.Color.fromHex(code: "#A4A6B3")),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.Color.fromHex(code: "#A4A6B3")))),

      ///Assign Bar Width
      defaultRenderer: new charts.BarRendererConfig(
        maxBarWidthPx: 20,
      ),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 16, // size in Pts.
                  color: charts.Color.fromHex(code: "#A4A6B3")),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.Color.fromHex(code: "#A4A6B3")))),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData({
    int MOverweight,
    int MUnderweight,
    int MNormal,
    int MObese,
    int FOverweight,
    int FUnderweight,
    int FNormal,
    int FObese,
  }) {
    final underweight = [
      new OrdinalSales(
        'Male',
        MUnderweight ?? 50,
        charts.Color.fromHex(
          code: underweightHex,
        ),
      ),
      new OrdinalSales(
        'Female',
        FUnderweight ?? 24,
        charts.Color.fromHex(
          code: underweightHex,
        ),
      ),
    ];

    final normal = [
      new OrdinalSales(
        'Male',
        MNormal ?? 25,
        charts.Color.fromHex(
          code: normalHex,
        ),
      ),
      new OrdinalSales(
        'Female',
        FNormal ?? 20,
        charts.Color.fromHex(
          code: normalHex,
        ),
      ),
    ];

    final overweight = [
      new OrdinalSales(
        'Male',
        MOverweight ?? 15,
        charts.Color.fromHex(
          code: overweightHex,
        ),
      ),
      new OrdinalSales(
        'Female',
        FOverweight ?? 45,
        charts.Color.fromHex(
          code: overweightHex,
        ),
      ),
    ];
    final obese = [
      new OrdinalSales(
        'Male',
        MObese ?? 30,
        charts.Color.fromHex(
          code: obeseHex,
        ),
      ),
      new OrdinalSales(
        'Female',
        FObese ?? 25,
        charts.Color.fromHex(
          code: obeseHex,
        ),
      ),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Obese',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: obese,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Overweight',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: overweight,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Normal',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: normal,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Underweight',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        colorFn: (OrdinalSales sales, _) => sales.color,
        data: underweight,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  final charts.Color color;
  OrdinalSales(this.year, this.sales, this.color);
}
