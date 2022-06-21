import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/models/student.dart';

typedef OnRowSelect = void Function(int index, String name);

class RegionDataTableSource extends DataTableSource {
  RegionDataTableSource({
    @required List<Region> regionData,
    @required this.onRowSelect,
  })  : _regionData = regionData,
        assert(regionData != null);

  final List<Region> _regionData;
  final OnRowSelect onRowSelect;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _regionData.length) {
      return null;
    }
    final _region = _regionData[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      onSelectChanged: (bool selected) {
        onRowSelect(index, _region.regionName);
      },
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text('${_region.regionName}')),
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
  int get rowCount => _regionData.length;

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
  void sort<T>(Comparable<T> Function(Region d) getField, bool ascending) {
    _regionData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
