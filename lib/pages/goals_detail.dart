import 'dart:convert';
import 'dart:io';

import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/models/nabung_model.dart';
import 'package:aturuang_project/utils/restapi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class GoalsDetail extends StatefulWidget {
  const GoalsDetail({Key? key}) : super(key: key);
  @override
  _GoalsDetail createState() => _GoalsDetail();
}

class _GoalsDetail extends State<GoalsDetail> {
  DataService ds = DataService();
  List<int> collectedArray = [];
  List<int> collected = [];

  String foto = "-";
  late ValueNotifier<int> _notifier;
  List<NabungModel> nabung = [];

  double targetAmount = 0.0;
  double currentAmount = 0.0;

  selectIdGoal(String id) async {
    List data = [];

    data = jsonDecode(await ds.selectId(token, project, 'nabung', appid, id));
    nabung = data.map((e) => NabungModel.fromJson(e)).toList();
    foto = nabung[0].foto;
    targetAmount = double.parse(nabung[0].target);
    for (NabungModel tabungan in nabung) {
      collectedArray = jsonDecode(tabungan.nominal).cast<int>();
      collected.add(collectedArray.fold(
          0, (previousValue, element) => previousValue + element));
    }
    currentAmount = double.parse(collected[0].toString());
  }

  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return formatter.format(amount);
  }

  // Future reloadDataGoals(dynamic value) async {
  //   setState(() {
  //     final args = ModalRoute.of(context)?.settings.arguments as List<String>;
  //     selectIdGoal(args[0]);
  //     collected.clear();
  //     collectedArray.clear();
  //   });
  // }

  //Profic
  File? image;
  String? imageProfpic;

  Future pickImage(String id) async {
    try {
      var picked = await FilePicker.platform.pickFiles(withData: true);

      if (picked != null) {
        var response = await ds.upload(token, project,
            picked.files.first.bytes!, picked.files.first.extension.toString());

        var file = jsonDecode(response);

        await ds.updateId('picture', file['file_name'], token, project,
            'mahasiswa', appid, id);

        foto = file['file_name'];

        // trigger change valueNotifier
        _notifier.value++;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    print(args[0]);

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
            "Goals Detail",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
          future: selectIdGoal(args[0]),
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
                    return Column(children: [
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              height: 204,
                              width: double.infinity,
                              child: Image.asset(
                                "assets/Meat.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 137, left: 25),
                                child: Row(
                                  children: [
                                    Text(
                                      nabung[0].nama,
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 21),
                                    const Icon(
                                      Icons.edit_square,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 29),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 19, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Target"),
                                          Text(
                                            "${formatCurrency(int.parse(targetAmount.toString()))}",
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: 314,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.grey[400],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: LinearProgressIndicator(
                                            value: currentAmount / targetAmount,
                                            backgroundColor: Colors.transparent,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    secondaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }
                }
            }
          },
        ));
  }
}
