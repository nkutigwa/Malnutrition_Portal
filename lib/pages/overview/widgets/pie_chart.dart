/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(
    this.seriesList, {
    this.animate,
  });

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData(
      {int normal, int obese, int underWeight, int overWeight}) {
    return new DonutPieChart(
      _createSampleData(
        normal: normal,
        obese: obese,
        underWeight: underWeight,
        overWeight: overWeight,
      ),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      // Configure the width of the pie slices to 60px. The remaining space in
      // the chart will be left as a hole in the center.
      defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 20,
          arcRendererDecorators: [new charts.ArcLabelDecorator()]),
    );
  }

  /// Create one series with sample data.
  static List<charts.Series<LinearSales, int>> _createSampleData(
      {int normal, int obese, int underWeight, int overWeight}) {
    final data = [
      new LinearSales(
        0,
        underWeight % 10,
        charts.Color.fromHex(
          code: "#3C19C06",
        ),
      ),
      new LinearSales(
        1,
        normal % 75,
        charts.Color.fromHex(
          code: "#8BC34A",
        ),
      ),
      new LinearSales(
        2,
        overWeight % 25,
        charts.Color.fromHex(
          code: "#FF9800",
        ),
      ),
      new LinearSales(
        3,
        obese % 5,
        charts.Color.fromHex(
          code: "#FF5252",
        ),
      ),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final charts.Color color;

  LinearSales(this.year, this.sales, this.color);
}

///Pie Chart Details
class DetailsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 30.0,
          width: 200.0,
          child: ListTile(
            leading: Icon(
              Icons.bookmark_rounded,
              color: Color(0xff3C19C0),
            ),
            title: Text(
              'Underweight',
              style: TextStyle(fontSize: 16.0, color: lightGrey),
            ),
          ),
        ),
        Container(
          height: 30.0,
          width: 200.0,
          child: ListTile(
            leading: Icon(
              Icons.bookmark_rounded,
              color: Color(0xff8BC34A),
            ),
            title: Text(
              'Normal',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontSize: 16.0, color: lightGrey),
            ),
          ),
        ),
        Container(
          height: 30.0,
          width: 200.0,
          child: ListTile(
            leading: Icon(
              Icons.bookmark_rounded,
              color: Color(0xffFF9800),
            ),
            title: Text(
              'Overweight',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontSize: 16.0, color: lightGrey),
            ),
          ),
        ),
        Container(
          height: 30.0,
          width: 200.0,
          child: ListTile(
            leading: Icon(
              Icons.bookmark_rounded,
              color: Color(0xffFF5252),
            ),
            title: Text(
              'Obese',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontSize: 16.0, color: lightGrey),
            ),
          ),
        ),
      ],
    );
  }
}
