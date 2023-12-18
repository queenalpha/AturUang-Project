import 'dart:convert';

import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:aturuang_project/models/laporan_model.dart';
import 'package:aturuang_project/models/nabung_model.dart';
import 'package:aturuang_project/utils/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  String username = '';
  late ValueNotifier<int> _notifier;
  int saving = 0;

  List<NabungModel> nabung = [];
  List<NabungModel> tabungan = [];
  List<LaporanKeuanganModel> lapKeu = [];

  List data = [];

  int totalIncome = 0;
  int totalSpending = 0;

  List<String> idTabungan = [];
  List<String> fotoTabungan = [];
  List<int> target = [];
  List<String> id_goals = [];
  List<String> goals = [];
  List<String> periode = [];
  List<int> collectedArray = [];
  List<int> collected = [];
  bool statusNabung = true;

  @override
  void initState() {
    _notifier = ValueNotifier<int>(0);
    // selectAllTabungan();
    selectWhereNabung();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeFirebase();
    });
  }

  Future reloadDataTabungan(dynamic value) async {
    setState(() {
      // selectAllTabungan();
      selectWhereNabung();
      idTabungan.clear();
      id_goals.clear();
      goals.clear();
      collected.clear();
      collectedArray.clear();
      target.clear();
      periode.clear();
      fotoTabungan.clear();
    });
  }

  selectWhereNabung() async {
    statusNabung = true;
    List data = [];
    data = jsonDecode(await ds.selectWhere(
        token, project, 'nabung', appid, 'user_id', currentUser!.uid));
    nabung = data.map((e) => NabungModel.fromJson(e)).toList();

    for (NabungModel tabungan in nabung) {
      idTabungan.add(tabungan.id);
      fotoTabungan.add(tabungan.foto);
      goals.add(tabungan.nama);
      id_goals.add(tabungan.id);
      target.add(int.parse(tabungan.target));
      periode.add(tabungan.periode);
      collectedArray = jsonDecode(tabungan.nominal).cast<int>();
      collected.add(collectedArray.fold(
          0, (previousValue, element) => previousValue + element));
    }
    if (nabung.isEmpty) {
      statusNabung = false;
    }
    // print("nabung:" + nabung.toString());
    // print("COLECTED array" + collectedArray.toString());
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();

    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      setState(() {
        selectWhereNabung();
      });
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
    saving = totalIncome - totalSpending;
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future:
              Future.wait<dynamic>([selectWhereLaporan(), selectWhereNabung()]),
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
                    print(id_goals.length.toString());
                    return SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 39,
                          ),
                          // Heading Area
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 29),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome, ${currentUser!.displayName}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Poppins-SemiBold',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 21),
                                AspectRatio(
                                  aspectRatio: 317 / 155,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Image.asset('assets/moneycard.png'),
                                        Positioned(
                                            top: 90,
                                            left: 27,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Total Savings",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontFamily:
                                                              'Poppins-Reguler',
                                                          color: Colors.white)),
                                                  Text(
                                                      formatCurrency(saving)
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily:
                                                              'Poppins-Reguler',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white)),
                                                ]))
                                      ],
                                    ),
                                  ),
                                ),
                                // Menu APPS Area
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30, top: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, 'goals_menu');
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Container(
                                                    color: primaryColor,
                                                    padding: EdgeInsets.all(8),
                                                    child: Image.asset(
                                                      "assets/IconGoals.png",
                                                      height: 35,
                                                      width: 35,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text("Goals"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 40),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            // Navigation to financial counting
                                            onTap: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  'counting',
                                                  (route) => false);
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Container(
                                                    color: primaryColor,
                                                    padding: EdgeInsets.all(8),
                                                    child: Image.asset(
                                                      "assets/IconCounting.png",
                                                      height: 35,
                                                      width: 35,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text("Counting"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 40),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            // Navigation to reporting
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context, 'reporting');
                                            },
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Container(
                                                    color: primaryColor,
                                                    padding: EdgeInsets.all(8),
                                                    child: Image.asset(
                                                      "assets/IconReporting.png",
                                                      height: 35,
                                                      width: 35,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text("Reporting"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 29),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Container(
                                    height: 3,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 24),
                                // Financial Display Report Area
                                Row(
                                  children: [
                                    Container(
                                      width: screenWidth * 0.13,
                                      height: screenWidth * 0.13,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.02),
                                        border: Border.all(
                                          width: screenWidth * 0.002,
                                          color: Colors.grey[900]!,
                                        ),
                                        color: cardGrey,
                                      ),
                                      child: Icon(
                                        Icons.arrow_upward_sharp,
                                        size: screenWidth * 0.10,
                                        color: arrowUp,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Income",
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: screenWidth * 0.033,
                                            fontWeight: FontWeight.w300,
                                            color: secondaryColor,
                                          ),
                                        ),
                                        SizedBox(height: screenWidth * 0.02),
                                        //Ambil data INCOME dari API
                                        Text(
                                          formatCurrency(totalIncome)
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: screenWidth * 0.035,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenWidth * 0.10),
                                    Container(
                                      width: screenWidth * 0.13,
                                      height: screenWidth * 0.13,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.02),
                                        border: Border.all(
                                          width: screenWidth * 0.002,
                                          color: Colors.grey[900]!,
                                        ),
                                        color: cardGrey,
                                      ),
                                      child: Icon(
                                        Icons.arrow_downward_sharp,
                                        size: screenWidth * 0.10,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Spending",
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: screenWidth * 0.033,
                                            fontWeight: FontWeight.w300,
                                            color: secondaryColor,
                                          ),
                                        ),
                                        SizedBox(height: screenWidth * 0.02),
                                        // ambil data spending dari API
                                        Text(
                                          formatCurrency(totalSpending)
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Poppins-Bold',
                                            fontSize: screenWidth * 0.035,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                // GoalList Area
                                statusNabung == false
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Goals List",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins-Reguler',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
                                                  color: primaryColor)),
                                          SizedBox(height: 9),
                                          Text(
                                              "Anda belum memiliki Goals apapun!")
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // batasi Item countnya 2
                                          Text("Goals List",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins-Reguler',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
                                                  color: primaryColor)),
                                          SizedBox(height: 9),
                                          ListGoals(
                                              id_goal: id_goals[0],
                                              goals: goals[0],
                                              collected:
                                                  collected[0].toString(),
                                              target: target[0].toString(),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Warning"),
                                                      content: Text(
                                                          "Remove ${goals[0]} from your Goals?"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Cancel'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: const Text(
                                                              'Remove',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red)),
                                                          onPressed: () async {
                                                            bool response =
                                                                await ds.removeId(
                                                                    token,
                                                                    project,
                                                                    'nabung',
                                                                    appid,
                                                                    '${idTabungan[0]}');

                                                            if (response) {
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                              reloadDataTabungan(
                                                                  true);
                                                            }
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              imagePath: "${fotoTabungan[0]}"),
                                          SizedBox(height: 9),
                                          (id_goals.length / 4) >= 2
                                              ? ListGoals(
                                                  id_goal: id_goals[1],
                                                  goals: goals[1],
                                                  collected:
                                                      collected[1].toString(),
                                                  target: target[1].toString(),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Warning"),
                                                          content: Text(
                                                              "Remove ${goals[1]} from your Goals?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text(
                                                                  'Cancel'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  'Remove',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red)),
                                                              onPressed:
                                                                  () async {
                                                                bool response =
                                                                    await ds.removeId(
                                                                        token,
                                                                        project,
                                                                        'nabung',
                                                                        appid,
                                                                        '${idTabungan[1]}');

                                                                if (response) {
                                                                  Navigator.pop(
                                                                      context,
                                                                      true);
                                                                  reloadDataTabungan(
                                                                      true);
                                                                }
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  imagePath:
                                                      "${fotoTabungan[1]}",
                                                )
                                              : SizedBox(height: 9),

                                          SizedBox(height: 9),

                                          Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, 'goalist');
                                              },
                                              child: Text(
                                                "See More",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins-Reguler',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
                                                  color: primaryColor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
            }
          }),
    );
  }
}
