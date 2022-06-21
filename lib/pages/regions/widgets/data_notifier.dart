import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_web_dashboard/models/student.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;

class RegionDataNotifier with ChangeNotifier {
  RegionDataNotifier() {
    fetchData();
  }

  List<Region> get regionModel => _regionModel;

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

  List _regionModel = <Region>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    ///Fetch data from JSON from asset
    final String response = await rootBundle.loadString('assets/Regions.json');
    final data = await json.decode(response);
    var dist = data["features"];
    int len = dist.length;
    print(len);
    int i = 0;
    while (i < len) {
      _regionModel.add(
        Region(
          regionName: dist[i]["properties"]["region"].toString(),
        ),
      );
      i++;
    }

    print(_regionModel);
    notifyListeners();
  }
}
