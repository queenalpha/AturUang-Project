import 'dart:async';
import 'dart:convert';

import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:aturuang_project/models/laporan_model.dart';
import 'package:aturuang_project/utils/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../configuration/list_configuration.dart';
import '../configuration/theme_config.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);
  @override
  _ReportList createState() => _ReportList();
}

class _ReportList extends State<ReportList> {
  final StreamController<List<LaporanKeuanganModel>> _streamController =
      StreamController<List<LaporanKeuanganModel>>();
  String selectedFilter = 'All List';

  List data = [];
  List<LaporanKeuanganModel> lapKeu = [];
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  List<LaporanKeuanganModel> search_data = [];
  List<LaporanKeuanganModel> search_data_pre = [];

  selectWhereLaporan() async {
    data = jsonDecode(await ds.selectWhere(token, project, 'laporan_keuangan',
        appid, 'user_id', currentUser!.uid));
    lapKeu = data.map((e) => LaporanKeuanganModel.fromJson(e)).toList();
  }

  void filterLaporan(String category) {
    if (category == 'All List') {
      search_data = data.map((e) => LaporanKeuanganModel.fromJson(e)).toList();
    } else {
      search_data_pre =
          data.map((e) => LaporanKeuanganModel.fromJson(e)).toList();
      search_data = search_data_pre
          .where((lapkeu) =>
              lapkeu.kategori.toLowerCase().contains(category.toLowerCase()))
          .toList();
    }
    setState(() {
      lapKeu = search_data;
      _streamController.add(search_data);
    });
  }

  Future reloadDataLaporan(dynamic value) async {
    setState(() {
      selectWhereLaporan();
    });
  }

  @override
  void initState() {
    selectWhereLaporan();
    super.initState();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // all list
                      FutureBuilder<dynamic>(
                          future: selectWhereLaporan(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                {
                                  return const Text('none');
                                }
                              case ConnectionState.waiting:
                                {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              case ConnectionState.active:
                                {
                                  return const Text('Active');
                                }
                              case ConnectionState.done:
                                {
                                  if (snapshot.hasError) {
                                    return Text('${snapshot.error}',
                                        style:
                                            const TextStyle(color: Colors.red));
                                    // } else if (!snapshot.hasData ||
                                    //     snapshot.data!.isEmpty) {
                                    //   return Center(
                                    //     child: Text('you do not have goals yet.'),
                                    //   );
                                  } else {
                                    filterLaporan(selectedFilter);
                                    return Padding(
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
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return ListReporting(
                                                title:
                                                    '${search_data[index].kategori}',
                                                time:
                                                    '${search_data[index].tanggal}',
                                                date:
                                                    '${search_data[index].tanggal}',
                                                nominal:
                                                    '${search_data[index].nominal}',
                                              );
                                            },
                                            itemCount: search_data.length,
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                }
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // VALUE FILTER
  Widget _buildFilterDropdown() {
    return PopupMenuButton(
      icon: Icon(
        Icons.filter_list,
        color: Colors.black,
      ),
      onSelected: (value) {
        _selectFilterOption(value.toString());
        print(selectedFilter);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'All List',
          child: Row(
            children: [
              Text('All List'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Salary',
          child: Row(
            children: [
              Text('Salary'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Invest',
          child: Row(
            children: [
              Text('Invest'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Daily',
          child: Row(
            children: [
              Text('Daily'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Other',
          child: Row(
            children: [
              Text('Other'),
            ],
          ),
        )
      ],
    );
  }

  void _selectFilterOption(String option) {
    setState(() {
      selectedFilter = option;
    });
  }
}
