import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:aturuang_project/configuration/exporting_pdf.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:aturuang_project/configuration/exporting_pdf.dart'; 

class ReportingTable extends StatefulWidget {
  const ReportingTable({Key? key}) : super(key: key);

  @override
  _ReportingTableState createState() => _ReportingTableState();
}

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

class _ReportingTableState extends State<ReportingTable> {
  //Contoh Data
  List<Report> reports = [
    Report(
      date: '10/12/2023',
      category: 'Salary',
      description: 'Gajian di bulan Oktober kemarin.',
      amount: 1100000.0,
    ),
    Report(
      date: '11/12/2023',
      category: 'Salary',
      description: 'Ini gajian di bulan November',
      amount: 1500000.0,
    ),
    Report(
      date: '12/12/2023',
      category: 'Salary',
      description: 'Ini gajian di bulan Desember',
      amount: 1800000.0,
    ),
    Report(
      date: '12/01/2024',
      category: 'Salary',
      description: 'Ini gajian di bulan Januari',
      amount: 2000000.0,
    ),
  ];

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Reporting Salary",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(255, 20, 165, 182)),
                dataRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                columns: [
                  DataColumn(
                    label: Text('Date',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Colors.white,
                        )),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text('Description',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Colors.white,
                        )),
                    numeric: false,
                  ),
                  DataColumn(
                    label: Text('Amount',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          color: Colors.white,
                        )),
                    numeric: false,
                  ),
                ],
                rows: [
                  ...reports.map(
                    (report) => DataRow(cells: [
                      DataCell(Text(report.date ?? '')),
                      DataCell(
                        Flexible(
                          child: Text(
                            report.description ?? '',
                          ),
                        ),
                      ),
                      DataCell(Text('Rp${report.amount.toString()}')),
                    ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: RoundedButton(
                title: 'Export',
                onPressed: () {
                  ExportingPDF.exportToUserSelectedDirectory(reports);
                },
                width: 336,
                height: 51,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
