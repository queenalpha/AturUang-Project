import 'dart:convert';

import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:aturuang_project/models/laporan_model.dart';
import 'package:aturuang_project/utils/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../configuration/list_configuration.dart';
import '../configuration/theme_config.dart';

class ReportList extends StatefulWidget {
  List<LaporanKeuanganModel> lapKeuFiltered = [];
  String selectedTipe = '';
  @override
  _ReportListState createState() => _ReportListState();
  // String selectedOption = 'All List';
  ReportList(
      {Key? key,
      required List<LaporanKeuanganModel> lapKeuFiltered,
      required String selectedTipe})
      : super(key: key) {
    this.lapKeuFiltered = lapKeuFiltered;
    this.selectedTipe = selectedTipe;
  }
}

class _ReportListState extends State<ReportList> {
  int totalIncome = 0;
  int totalSpending = 0;
  int total = 0;
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;
  // String selectedFilter = 'All List';

  List<String> filterOptions = [
    'All List',
    'Salary',
    'Invest',
    'Daily',
    'Other'
  ];

  // List<LaporanKeuanganModel> filteredLapKeu() {
  //   if (widget.selectedTipe == 'All List') {
  //     return widget.lapKeuFiltered;
  //   } else {
  //     return widget.lapKeuFiltered
  //         .where((keuangan) => keuangan.kategori == widget.selectedTipe)
  //         .toList();
  //   }
  // }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return 'Bulan tidak valid';
    }
  }

  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    print("TAHU ${widget.lapKeuFiltered.last.kategori}");
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
        title: Text("${widget.selectedTipe} Reporting",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: widget.lapKeuFiltered.length,
          itemBuilder: (context, index) {
            final reversedIndex = widget.lapKeuFiltered.length - 1 - index;
            return ListReporting(
                title: '${widget.lapKeuFiltered[reversedIndex].kategori}',
                time:
                    '${DateTime.parse(widget.lapKeuFiltered[reversedIndex].tanggal).hour}:${DateTime.parse(widget.lapKeuFiltered[reversedIndex].tanggal).minute}',
                date:
                    '${DateTime.parse(widget.lapKeuFiltered[reversedIndex].tanggal).day} ${getMonthName(DateTime.parse(widget.lapKeuFiltered[reversedIndex].tanggal).month)} ${DateTime.parse(widget.lapKeuFiltered[reversedIndex].tanggal).year}',
                nominal:
                    '${formatCurrency(int.parse(widget.lapKeuFiltered[reversedIndex].nominal))}',
                isIncome: widget.lapKeuFiltered[reversedIndex].tipe_keuangan ==
                    'Income');
          }),
    );
  }

  // VALUE FILTER
  Widget _buildFilterDropdown() {
    return PopupMenuButton(
      icon: Icon(
        Icons.filter_list,
        color: Colors.black,
      ),
      // color: Colors.black,
      onSelected: (value) {
        _selectFilterOption(value.toString());
        print("SELELCTTEDD: " + widget.selectedTipe.toString());
      },
      itemBuilder: (BuildContext context) => filterOptions
          .map((value) => PopupMenuItem(
                value: value,
                child: Row(
                  children: [
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      // [
      //   PopupMenuItem(
      //     value: 'All List',
      //     child: Row(
      //       children: [
      //         Text('All List'),
      //       ],
      //     ),
      //   ),
      //   PopupMenuItem(
      //     value: 'Salary',
      //     child: Row(
      //       children: [
      //         Text('Salary'),
      //       ],
      //     ),
      //   ),
      //   PopupMenuItem(
      //     value: 'Invest',
      //     child: Row(
      //       children: [
      //         Text('Invest'),
      //       ],
      //     ),
      //   ),
      //   PopupMenuItem(
      //     value: 'Daily',
      //     child: Row(
      //       children: [
      //         Text('Daily'),
      //       ],
      //     ),
      //   ),
      //   PopupMenuItem(
      //     value: 'Other',
      //     child: Row(
      //       children: [
      //         Text('Other'),
      //       ],
      //     ),
      //   ),
      // ],
    );
  }

  void _selectFilterOption(String option) {
    setState(() {
      widget.selectedTipe = option;
    });
  }
}
