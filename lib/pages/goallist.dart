import 'dart:convert';

import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/models/nabung_model.dart';
import 'package:aturuang_project/utils/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoalsList extends StatefulWidget {
  const GoalsList({Key? key, required String title}) : super(key: key);
  @override
  _GoalsList createState() => _GoalsList();
}

class _GoalsList extends State<GoalsList> {
  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0, // Jumlah digit di belakang koma
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
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Goals List",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: TabunganList()
        //       return ListView.builder(
        //           itemCount: data!.length,
        //           itemBuilder: (context, index) {
        //             List<int> collected = [];
        //             collected.add(jsonDecode(data[index]['nominal'])
        //                 .cast<int>()
        //                 .fold(0,
        //                     (previousValue, element) => previousValue + element));
        //             return Column(
        //               children: [
        //                 Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 29),
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsets.only(top: 15),
        //                           child: Text(
        //                             "Day",
        //                             style: TextStyle(
        //                               fontSize: 15,
        //                               fontFamily: 'Poppins-Bold',
        //                               fontWeight: FontWeight.w800,
        //                             ),
        //                           ),
        //                         ),
        //                         SizedBox(
        //                             height:
        //                                 6), // Category Goals (DAY, WEEK, YEAR)
        //                         ListGoals(
        //                             goals: '${data[index]['nama']}',
        //                             // goals: '${data[index]['nama']}',
        //                             collected:
        //                                 '${parseAndConvert(collected.toString())}',
        //                             target: '${data[index]['target']}',
        //                             onPressed: () {},
        //                             imagePath: "assets/Mobil.jpg"),
        //                         SizedBox(height: 6),
        //                       ],
        //                     ))
        //               ],
        //             );
        //           });
        //     }
        //   },
        // ),

        );
  }
}

int parseAndConvert(String input) {
  // Menghapus tanda kurung siku dan mengonversi menjadi string murni
  String cleanString = input.replaceAll('[', '').replaceAll(']', '');

  // Mengubah string menjadi nilai integer
  int result = int.tryParse(cleanString) ?? 0;

  return result;
}

Future<List<dynamic>> selectAllTabungan() async {
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  try {
    List<dynamic> data = jsonDecode(await ds.selectWhere(
        token, project, 'nabung', appid, 'user_id', currentUser?.uid ?? ''));

    return List<dynamic>.from(data);
  } catch (e) {
    print('Error during selectAllTabungan: $e');
    return [];
  }
}

class TabunganList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: selectAllTabungan(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('Tidak ada data mahasiswa.'),
                  );
                } else {
                  List<dynamic> tabunganList = snapshot.data!;

                  List<NabungModel> tabunganHarian = tabunganList
                      .where((tabungan) => tabungan["periode"] == "Day")
                      .map((json) => NabungModel.fromJson(json))
                      .toList();

                  List<NabungModel> tabunganMingguan = tabunganList
                      .where((tabungan) => tabungan["periode"] == "Week")
                      .map((json) => NabungModel.fromJson(json))
                      .toList();

                  List<NabungModel> tabunganBulanan = tabunganList
                      .where((tabungan) => tabungan["periode"] == "Month")
                      .map((json) => NabungModel.fromJson(json))
                      .toList();
                  return ListView(
                    children: [
                      TabunganSection('Day', tabunganHarian),
                      TabunganSection('Week', tabunganMingguan),
                      TabunganSection('Month', tabunganBulanan),
                    ],
                  );
                }
              }
          }
        });
  }
}

class TabunganSection extends StatefulWidget {
  final String judul;
  final List<dynamic> tabunganList;
  TabunganSection(this.judul, this.tabunganList);

  @override
  _TabunganSectionState createState() => _TabunganSectionState();
}

class _TabunganSectionState extends State<TabunganSection> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.judul,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.tabunganList.length,
            itemBuilder: (context, index) {
              DataService ds = DataService();
              NabungModel tabungan = widget.tabunganList[index];
              List<int> collected = [];
              collected.add(jsonDecode(tabungan.nominal).cast<int>().fold(
                  0, (previousValue, element) => previousValue + element));
              return Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 6), // Category Goals (DAY, WEEK, YEAR)
                          ListGoals(
                              goals: '${tabungan.nama}',
                              collected:
                                  '${parseAndConvert(collected.toString())}',
                              target: '${tabungan.target}',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Warning"),
                                      content: Text(
                                          "Remove ${tabungan.nama} from your Goals?"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Remove',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          onPressed: () async {
                                            bool response = await ds.removeId(
                                                token,
                                                project,
                                                'nabung',
                                                appid,
                                                tabungan.id);

                                            if (response) {
                                              Navigator.pop(context, true);
                                              setState(() {
                                                widget.tabunganList
                                                    .remove(tabungan);
                                              });
                                            }
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              imagePath: "assets/Mobil.jpg"),
                          SizedBox(height: 6),
                        ],
                      ))
                ],
              );
            })
      ],
    );
  }
}
