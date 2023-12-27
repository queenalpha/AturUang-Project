import 'dart:io';
import 'dart:typed_data'; // Add this import for Uint8List
import 'dart:html' as html; // Add this import for html
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aturuang_project/pages/table_reporting.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';

class ExportingPDF {
  static User? currentUser = FirebaseAuth.instance.currentUser;
  static String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return formatter.format(amount);
  }

  static Future<void> exportToUserSelectedDirectory(
      List<Report> reports) async {
    try {
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
                  ),
                ),

                pw.SizedBox(height: 20),
                //user and date information
                pw.Text(
                    'Username: ${currentUser!.displayName}'), //ambil dari data username
                pw.Text(
                    'Date Report: $formattedDate'), //date time pengambilan daya
                pw.Text(
                    'Reporting Category: ${reports.first.category}'), //ambil data kategori

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
                        report.date != null
                            ? DateFormat('dd/MM/yy')
                                .format(DateTime.parse(report.date!))
                            : '',
                        report.description ?? '',
                        '${formatCurrency(int.parse(report.amount.toString()))}'
                      ],
                    [
                      'Total',
                      '',
                      '${formatCurrency(int.parse(reports.map((report) => report.amount ?? 0).reduce((a, b) => a + b).toString()))}',
                    ],
                  ],
                ),
              ],
            );
          },
        ),
      );

      // Convert PDF to bytes
      final Uint8List uint8List = await pdf.save();

      // Create a Blob from the bytes
      final blob = html.Blob([uint8List]);

      // Create an object URL from the Blob
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create an anchor element
      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download =
            '${DateFormat('dd_MM_yyyy').format(DateTime.now())}_LaporanKeuangan_${DateTime.now().second}.pdf'; // Set your desired file name here

      // Trigger a click on the anchor element
      anchor.click();

      // Revoke the object URL to free up resources
      html.Url.revokeObjectUrl(url);

      // Dialog
      print('The table data has been exported');
    } catch (e) {
      print('An error occurred while exporting the table data: $e');
    }
  }
}
