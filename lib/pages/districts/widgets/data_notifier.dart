import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_web_dashboard/models/student.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;

class DistrictDataNotifier with ChangeNotifier {
  DistrictDataNotifier() {
    fetchData();
  }

  List<District> get districtModel => _districtModel;

  // SORT COLUMN INDEX...

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  // -------------------------------------- INTERNALS --------------------------------------------

  List _districtModel = <District>[
//    District(region: "KEnya", districtName: "Rkse"),
  ];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    ///Fetch data from JSON from asset
    final String response =
        await rootBundle.loadString('assets/Districts.json');
    final data = await json.decode(response);
    var dist = data["features"];
    int len = dist.length;
//    print(len);
    int i = 0;
    while (i < len) {
      _districtModel.add(
        District(
          region: dist[i]["properties"]["region"].toString(),
          districtName: dist[i]["properties"]["District"].toString(),
        ),
      );
      i++;
    }

//    print(_districtModel);
    notifyListeners();
  }
}
