import 'dart:convert';

import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:aturuang_project/models/laporan_model.dart';
import 'package:aturuang_project/utils/restapi.dart';
import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:chart_it/chart_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:intl/intl.dart';
import 'package:aturuang_project/configuration/theme_config.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class ReportingPage extends StatefulWidget {
  const ReportingPage({Key? key}) : super(key: key);
  @override
  _ReportingPageState createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  int totalIncome = 0;
  int totalSpending = 0;
  int total = 0;
  List<LaporanKeuanganModel> lapKeu = [];
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;

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

  String selectedFilter = 'Option 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                height: 500,
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/background.png',
                                  // width: double.infinity,
                                  // height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              AppBar(
                                leadingWidth: 100,
                                leading: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, 'home', (route) => false);
                                  },
                                ),
                                // Warna latar belakang transparan
                                backgroundColor: Colors.transparent,
                                // Atur elevasi ke 0 untuk menghilangkan bayangan AppBar
                                elevation: 0,
                                centerTitle: true,
                                title: Text('Reporting',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 20)),
                              ),

                              //Chart Start
                              Padding(
                                padding: const EdgeInsets.all(45.0),
                                child: Center(
                                  child: PieChart(
                                    chartStyle: RadialChartStyle(
                                        backgroundColor: Colors.transparent),
                                    animationDuration:
                                        const Duration(milliseconds: 500),
                                    height: 350,
                                    width: 350,
                                    // animateOnUpdate: true,
                                    // animateOnLoad: true,
                                    data: PieSeries(
                                      donutRadius: 70.0,
                                      donutSpaceColor: Colors.transparent,
                                      donutLabel: () =>
                                          '${formatCurrency(total)}',
                                      donutLabelStyle: ChartTextStyle(
                                          textStyle: TextStyle(
                                              fontFamily: 'Poppins-SemiBold',
                                              fontSize: 19,
                                              color: Colors.white)),
                                      slices: <SliceData>[
                                        SliceData(
                                            style: SliceDataStyle(
                                              radius: 100,
                                              color: Color.fromARGB(
                                                  255, 38, 243, 169),
                                              labelPosition: 150,
                                              strokeWidth: 0.0,
                                              strokeColor: Colors.white,
                                            ),
                                            label: (_, value) =>
                                                '${formatCurrency(totalIncome)}',
                                            labelStyle: ChartTextStyle(
                                                textStyle: TextStyle(
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                            value: totalIncome),
                                        SliceData(
                                            style: SliceDataStyle(
                                              radius: 100,
                                              color: Color.fromARGB(
                                                  255, 255, 84, 71),
                                              labelPosition: 150,
                                              strokeWidth: 0.0,
                                              strokeColor: Colors.white,
                                            ),
                                            label: (_, value) =>
                                                '${formatCurrency(totalSpending)}',
                                            labelStyle: ChartTextStyle(
                                                textStyle: TextStyle(
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                            value: totalSpending),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //chart end

//Legend Start
                              Padding(
                                padding: const EdgeInsets.only(top: 400.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LegendItem(
                                      color: const Color.fromARGB(
                                          255, 38, 243, 169),
                                      label: 'Income',
                                    ),
                                    SizedBox(width: 20),
                                    LegendItem(
                                      color: Color.fromARGB(255, 255, 84, 71),
                                      label: 'Spending',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Toggle Button
                        Container(
                          child: Center(
                            child: ToggleButton(
                              isSelected: [true, false, false],
                              buttonLabels: ["All", "Income", "Spending"],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // all list
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Text(
                                  'All list',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                            ],
                          ),
                        ),

                        SingleChildScrollView(
                            // sengaja dikasih ini biar kalo banyak ngga overflow
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: lapKeu.length,
                                itemBuilder: (context, index) {
                                  final reversedIndex =
                                      lapKeu.length - 1 - index;
                                  return Container(
                                    child: ListReporting(
                                        title:
                                            '${lapKeu[reversedIndex].kategori}',
                                        time:
                                            '${DateTime.parse(lapKeu[reversedIndex].tanggal).hour}:${DateTime.parse(lapKeu[reversedIndex].tanggal).minute}',
                                        date:
                                            '${DateTime.parse(lapKeu[reversedIndex].tanggal).day} ${getMonthName(DateTime.parse(lapKeu[reversedIndex].tanggal).month)} ${DateTime.parse(lapKeu[reversedIndex].tanggal).year}',
                                        nominal:
                                            '${formatCurrency(int.parse(lapKeu[reversedIndex].nominal))}'),
                                  );
                                })),
                        Center(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'reportList');
                                },
                                child: Text(
                                  "See More",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Reguler',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ))),
                      ],
                    ),
                  );
                }
              }
          }
        },
      ),
      // bottomNavigationBar: NavigationBarDemo(),
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
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'Option 1',
          child: Row(
            children: [
              Text('Option 1'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Option 2',
          child: Row(
            children: [
              Text('Option 2'),
            ],
          ),
        ),
      ],
    );
  }

  void _selectFilterOption(String option) {
    setState(() {
      selectedFilter = option;
    });
  }
}
