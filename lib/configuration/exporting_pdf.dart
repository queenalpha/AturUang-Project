// exporting_pdf.dart
import 'dart:io';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/pages/table_reporting.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';

class ExportingPDF {
  static Future<void> exportToUserSelectedDirectory(
      List<Report> reports) async {
    try {
      // buat user milih directory
      final directory = await FilePicker.platform.getDirectoryPath();

      // ngecek file di directory ada
      if (directory != null) {
        //kalo ada ngambil report ke directory
        await _exportToUserSelectedDirectory(reports, directory);
      } else {
        print('Canceled');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  static Future<void> _exportToUserSelectedDirectory(
      List<Report> reports, String directory) async {
    try {
      // buat nama file
      final fileName =
          'Laporan Aturuang_${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}.pdf';
      final filePath = '$directory/$fileName';

      // Create a PDF document
      final pdf = pw.Document();

      String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      // Add a page to the PDF
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                //Title
                pw.Center(
                    child: pw.Text(
                  'Financial Reporting',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )),

                pw.SizedBox(height: 20),
                //user and date information
                pw.Text('Username: Asepfikri'), //ambil dari data username
                pw.Text(
                    'Date Report: $formattedDate'), //date time pengambilan daya
                pw.Text('Reporting Category: Salary'), //ambil data kategori

                pw.SizedBox(height: 20),
                // Table
                pw.Table.fromTextArray(
                  context: context,
                  cellAlignment: pw.Alignment.centerLeft,
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('14A5B6'),
                  ),
                  cellStyle: pw.TextStyle(fontSize: 10),
                  headerStyle: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  data: [
                    ['Date', 'Description', 'Amount'],
                    for (final report in reports)
                      [
                        report.date ?? '',
                        report.description ?? '',
                        'Rp${report.amount.toString()}'
                      ],
                    [
                      'Total',
                      '',
                      'Rp${reports.map((report) => report.amount ?? 0).reduce((a, b) => a + b)}',
                    ],
                  ],
                ),
              ],
            );
          },
        ),
      );

      // ngesave file ke pdf
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      //dialog
      print('The table data has been exported');
    } catch (e) {
      print('An error occurred while exporting the table data: $e');
    }
  }
}
