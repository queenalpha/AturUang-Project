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
  @override
  _ReportList createState() => _ReportList();
  // String selectedOption = 'All List';
  ReportList({Key? key}) : super(key: key);
}

class _ReportList extends State<ReportList> {
  int totalIncome = 0;
  int totalSpending = 0;
  int total = 0;
  List<LaporanKeuanganModel> lapKeu = [];
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;
  String selectedFilter = 'All List';

  List<String> filterOptions = [
    'All List',
    'Salary',
    'Invest',
    'Daily',
    'Other'
  ];

  List<LaporanKeuanganModel> filteredLapKeu() {
    if (selectedFilter == 'All List') {
      return lapKeu;
    } else {
      return lapKeu
          .where((keuangan) => keuangan.kategori == selectedFilter)
          .toList();
    }
  }

  selectWhereLaporan() async {
    List data = [];
    data = jsonDecode(await ds.selectWhere(token, project, 'laporan_keuangan',
        appid, 'user_id', currentUser?.uid ?? ''));
    lapKeu = data.map((e) => LaporanKeuanganModel.fromJson(e)).toList();

    List<LaporanKeuanganModel> income = [];
    List<LaporanKeuanganModel> spending = [];

    for (LaporanKeuanganModel keuangan in lapKeu) {
      if (keuangan.tipe_keuangan == "Income") {
        income.add(keuangan);
      } else if (keuangan.tipe_keuangan == "Spending") {
        spending.add(keuangan);
      }
    }

    totalIncome =
        income.fold(0, (sum, keuangan) => sum + int.parse(keuangan.nominal));
    totalSpending =
        spending.fold(0, (sum, keuangan) => sum + int.parse(keuangan.nominal));
    total = totalIncome + totalSpending;
  }

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
          title: Text("Reporting", style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
          future: selectWhereLaporan(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                {
                  return const Text('none');
                }
              case ConnectionState.waiting:
                {
                  return const Center(child: CircularProgressIndicator());
                }
              case ConnectionState.active:
                {
                  return const Text('Active');
                }
              case ConnectionState.done:
                {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}',
                        style: const TextStyle(color: Colors.red));
                  } else {
                    return Column(
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // all list
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${selectedFilter}',
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        _buildFilterDropdown(),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                      itemCount: filteredLapKeu().length,
                                      itemBuilder: (context, index) {
                                        bool isIncome =
                                            filteredLapKeu()[index].kategori ==
                                                    'Income'
                                                ? true
                                                : false;
                                        print("LENGHTT: " +
                                            filteredLapKeu().length.toString());
                                        return GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, 'reportTable'),
                                          child: ListReporting(
                                            title:
                                                '${filteredLapKeu()[index].kategori}',
                                            time:
                                                '${DateTime.parse(filteredLapKeu()[index].tanggal).hour}:${DateTime.parse(filteredLapKeu()[index].tanggal).minute}',
                                            date:
                                                '${DateTime.parse(filteredLapKeu()[index].tanggal).day} ${getMonthName(DateTime.parse(filteredLapKeu()[index].tanggal).month)} ${DateTime.parse(filteredLapKeu()[index].tanggal).year}',
                                            nominal:
                                                '${formatCurrency(int.parse(filteredLapKeu()[index].nominal))}',
                                            isIncome: isIncome,
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                }
            }
          },
        ));
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
        print(selectedFilter);
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
      selectedFilter = option;
    });
  }
}
