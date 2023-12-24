import 'package:flutter/material.dart';

import '../configuration/list_configuration.dart';
import '../configuration/theme_config.dart';

class ReportingTable extends StatefulWidget {
  const ReportingTable({Key? key}) : super(key: key);
  @override
  _ReportingTable createState() => _ReportingTable();
}

//ini buat bikin data static tapi datanya blum dibikin
class Report {
  String? date;
  String? category;
  String? description;
  double? amount;

  Report({
    required this.date,
    required this.category,
    required this.description,
    required this.amount,
  });
}

class _ReportingTable extends State<ReportingTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, 'reporting', (route) => false),
          ),
          title: Text(
              "Reporting Salary", //Title berdasarkan category ("Reporting ${"category"}")
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Category')),
                DataColumn(
                  label: Text('Description'),
                ),
                DataColumn(label: Text('Amount')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("12/12/2023")),
                  DataCell(Text("Salary")),
                  DataCell(
                    Expanded(
                      child: Text(
                        "Salary in novembery",
                        maxLines: 4, //kalo teksnya panjang dibatasi
                        overflow:
                            TextOverflow.ellipsis, // jjadi dot (contoh...)
                      ),
                    ),
                  ),
                  DataCell(Center(
                      child:
                          Text("1.000.000"))), //dibuat to string kalo ga kebaca
                ]),
              ],
            ),
          ),
        )

        // scrollDirection: Axis.horizontal,
        //
        );
  }
}
