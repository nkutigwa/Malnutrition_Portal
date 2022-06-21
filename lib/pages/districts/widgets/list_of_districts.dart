import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/models/student.dart';
//import 'package:flutter_web_dashboard/pages/districts/districts.dart';
//import 'package:flutter_web_dashboard/routing/routes.dart';
import 'package:flutter_web_dashboard/widgets/custom_dialog.dart';
import 'package:flutter_web_dashboard/widgets/custom_pagenated_table.dart';
import 'package:provider/provider.dart';
//import '../other_districts_data.dart';
import 'data_notifier.dart';
import 'data_table_const.dart';
import 'data_table_src.dart';

class ListOfDistricts extends StatelessWidget {
  final Function onRowSelected;

  ListOfDistricts({Key key, this.onRowSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<DistrictDataNotifier>();
    final _model = _provider.districtModel;
    if (_model.isEmpty) {
//      return const SizedBox.shrink();
      return Text("EMpty");
    }
    final _dtSource = DistrictDataTableSource(
      ///TODO onRowSelect Navigate to District Page
      onRowSelect: (index, name) {
        onRowSelected(name);
        _showDetails(context, _model[index]);
      },

      districtData: _model,
    );

    return Container(
//        height: 900,
        width: 400,
        constraints: BoxConstraints(
          minHeight: 700,
          maxHeight: 1145,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.only(bottom: 30),
        child: CustomPaginatedTable(
          dataColumns: _colGen(_dtSource, _provider),
          header: const Text(DataTableConstants.dtTitle),
          onRowChanged: (index) => _provider.rowsPerPage = index,
          rowsPerPage: _provider.rowsPerPage,
          showActions: true,
          source: _dtSource,
          sortColumnIndex: _provider.sortColumnIndex,
          sortColumnAsc: _provider.sortAscending,
        ));
  }
}

List<DataColumn> _colGen(
  DistrictDataTableSource _src,
  DistrictDataNotifier _provider,
) =>
    <DataColumn>[
//      DataColumn(
//        label: Text(DataTableConstants.colID),
//        numeric: true,
//        tooltip: DataTableConstants.colID,
////        onSort: (colIndex, asc) {
////          _sort<num>((district) => district.id, colIndex, asc, _src, _provider);
////        },
//      ),
      DataColumn(
        label: Text(DataTableConstants.colName),
        tooltip: DataTableConstants.colName,
        onSort: (colIndex, asc) {
          _sort<String>((district) => district.districtName, colIndex, asc,
              _src, _provider);
        },
      ),
      DataColumn(
        label: Text(DataTableConstants.colRegion),
        tooltip: DataTableConstants.colRegion,
        onSort: (colIndex, asc) {
          _sort<String>(
              (district) => district.region, colIndex, asc, _src, _provider);
        },
      ),
    ];

void _sort<T>(
  Comparable<T> Function(District district) getField,
  int colIndex,
  bool asc,
  DistrictDataTableSource _src,
  DistrictDataNotifier _provider,
) {
  _src.sort<T>(getField, asc);
  _provider.sortAscending = asc;
  _provider.sortColumnIndex = colIndex;
}

void _showDetails(
  BuildContext c,
  District data,
) async =>
    await showDialog<bool>(
      context: c,
      builder: (_) => CustomDialog(
        showPadding: false,
        child: Text(data.districtName + " Data"),
      ),
    );
