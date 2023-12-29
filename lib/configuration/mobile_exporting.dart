import 'dart:io';
import 'package:Aturuang/pages/table_reporting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
      // Request storage permission
      final PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        // Get user-selected directory
        final String? directory = await FilePicker.platform.getDirectoryPath();

        // Check if the directory is null
        if (directory != null) {
          // If not null, export to the selected directory
          await _exportToUserSelectedDirectory(reports, directory);
        } else {
          print('Canceled: Directory is null.');
        }
      } else {
        print('Permission denied for storage.');
      }
    } catch (e) {
      print('An error occurred in exportToUserSelectedDirectory: $e');
    }
  }

  static Future<void> _exportToUserSelectedDirectory(
      List<Report> reports, String directory) async {
    try {
      // Create a PDF document
      final pdf = pw.Document();

      // Add a page to the PDF
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Title
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
                // User and date information
                pw.Text('Username: ${currentUser!.displayName}'),
                pw.Text(
                    'Date Report: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
                pw.Text('Reporting Category: ${reports.first.category}'),

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
                        '${formatCurrency(int.parse(report.amount.toString()))}',
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

      // Build the file path
      final fileName =
          '${DateFormat('dd_MM_yyyy').format(DateTime.now())}_LaporanKeuangan_${DateTime.now().second}.pdf';
      final filePath = '$directory/$fileName';

      // Check if the file already exists
      final file = File(filePath);
      if (await file.exists()) {
        // Handle file existence (e.g., ask the user to overwrite)
        print('File already exists: $filePath');
        return;
      }

      // Write the PDF file
      await file.writeAsBytes(await pdf.save());
      // Dialog or notification
      print('The table data has been exported to: $filePath');
    } catch (e) {
      print('An error occurred while exporting the table data: $e');
    }
  }
}
