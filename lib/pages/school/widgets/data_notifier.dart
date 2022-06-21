import 'dart:async';
import 'dart:convert';
//
import 'package:flutter/services.dart';
import 'package:flutter_web_dashboard/models/student.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show PaginatedDataTable;
import 'package:flutter_web_dashboard/helpers/search.dart';

class SchoolDataNotifier with ChangeNotifier {
  SchoolDataNotifier() {
    fetchData();
  }

  List<School> get schoolModel => _schoolModel;

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

  List _schoolModel = <School>[];

  int _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    ///Fetch data from JSON from asset
    //  final String response = await rootBundle.loadString('assets/Schools.json');
    //  final data = await json.decode(response);
    //  var dist = data["features"];
    List schls = School.schools;
    int len = schls.length;
//    print(len);
    int i = 0;
    while (i < len) {
      _schoolModel.add(
        School(
          name: schls[i].toString(),

          //district: schls[i]["properties"]["district"].toString(),
          // region: schls[i]["properties"]["region"].toString(),
          // name: schls[i]["properties"]["School"].toString(),
        ),
      );
      i++;
    }

    print(_schoolModel);
    notifyListeners();
  }
}
