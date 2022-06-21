import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/student.dart';

typedef OnRowSelect = void Function(int index, String name);

class DistrictDataTableSource extends DataTableSource {
  DistrictDataTableSource({
    @required List<District> districtData,
    @required this.onRowSelect,
  })  : _districtData = districtData,
        assert(districtData != null);

  final List<District> _districtData;
  final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _districtData.length) {
      return null;
    }
    final _district = _districtData[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      onSelectChanged: (bool selected) {
        onRowSelect(index, _district.districtName);
      },
      cells: <DataCell>[
//        DataCell(Text(index.toString())),
        DataCell(Text('${_district.districtName}')),
        DataCell(Text('${_district.region}')),
//        DataCell(
//          IconButton(
//            hoverColor: Colors.transparent,
//            splashColor: Colors.transparent,
//            icon: const Icon(Icons.details),
//            onPressed: () => onRowSelect(index),
//          ),
//        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _districtData.length;

  @override
  int get selectedRowCount => 0;

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.
    The [compare] function must act as a [Comparator].
    List<String> numbers = ['two', 'three', 'four'];
// Sort from shortest to longest.
    numbers.sort((a, b) => a.length.compareTo(b.length));
    print(numbers);  // [two, four, three]
    The default List implementations use [Comparable.compare] if [compare] is omitted.
    List<int> nums = [13, 2, -11];
    nums.sort();
    print(nums);  // [-11, 2, 13]
   */
  void sort<T>(Comparable<T> Function(District d) getField, bool ascending) {
    _districtData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
