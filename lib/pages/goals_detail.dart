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
  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<int>(0);
  }

  int numberOfDates = 0;
  DataService ds = DataService();
  List<int> collectedArray = [];
  List<int> collectedArray2 = [];
  List<DateTime> collectedDate = [];
  List<NabungModel> tabungan = [];
  List<int> collected = [];
  final _amountTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? currentUser = FirebaseAuth.instance.currentUser;

  final _focusAmount = FocusNode();

  String foto = "-";
  late ValueNotifier<int> _notifier;
  List<NabungModel> nabung = [];
  List<NabungModel> nabung2 = [];

  double targetAmount = 0.0;
  double currentAmount = 0.0;

  late ValueKey<double> progressIndicatorKey = ValueKey<double>(currentAmount);

  selectIdGoal(String id) async {
    List data = [];

    data = jsonDecode(await ds.selectId(token, project, 'nabung', appid, id));
    nabung = data.map((e) => NabungModel.fromJson(e)).toList();
    foto = nabung[0].foto;

    DateTime date;
    String stringDate = '';
    stringDate = nabung[0].tanggal;
    List<String> dateStrings =
        stringDate.replaceAll("[", "").replaceAll("]", "").split(",");

    for (String dateString in dateStrings) {
      String trimmedDateString = dateString.trim().replaceAll("'", "");
      DateTime dateTime = DateTime.parse(trimmedDateString);
      collectedDate.add(dateTime);
    }
    targetAmount = double.parse(nabung[0].target);
    collectedArray = jsonDecode(nabung[0].nominal).cast<int>();
    collected.add(collectedArray.fold(
        0, (previousValue, element) => previousValue + element));

    currentAmount = double.parse(collected[0].toString());

    List<String> dateList =
        nabung[0].tanggal.replaceAll('[', '').replaceAll(']', '').split(', ');
    numberOfDates = dateList.length;
  }

  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return formatter.format(amount);
  }

  Future reloadDataGoal(dynamic value) async {
    setState(() {
      final args = ModalRoute.of(context)?.settings.arguments as List<String>;
      selectIdGoal(args[0]);
    });
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
                              child: Image.network(
                                fileUri + nabung[0].foto,
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
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 21),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                                context, 'goals_edit',
                                                arguments: [args[0]])
                                            .then(reloadDataGoal);
                                      },
                                      child: Icon(
                                        Icons.edit_square,
                                        size: 20.0,
                                        color: Colors.black,
                                      ),
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
                                            key: progressIndicatorKey,
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
                            SizedBox(height: 18),
                            Row(
                              children: [
                                Form(
                                    key: _formKey,
                                    child: Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          prefixText: 'Rp.  ',
                                          prefixStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintText: 'Enter the amount of money',
                                          border: OutlineInputBorder(),
                                        ),
                                        focusNode: _focusAmount,
                                        controller: _amountTextController,
                                        validator: (value) => value == ''
                                            ? 'Masukkan nomila!'
                                            : null,
                                      ),
                                    )),
                                SizedBox(width: 8),
                                RoundedButton(
                                  color: primaryColor,
                                  title: 'Add',
                                  onPressed: () async {
                                    _focusAmount.unfocus();
                                    collectedArray.clear();
                                    collectedDate.clear();
                                    if (_formKey.currentState!.validate()) {
                                      List data = [];
                                      data = jsonDecode(await ds.selectId(token,
                                          project, "nabung", appid, args[0]));
                                      nabung = data
                                          .map((e) => NabungModel.fromJson(e))
                                          .toList();
                                      DateTime date;
                                      String stringDate = '';
                                      collectedArray =
                                          jsonDecode(nabung[0].nominal)
                                              .cast<int>();
                                      collected.add(collectedArray.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue + element));
                                      stringDate = nabung[0].tanggal;
                                      List<String> dateStrings = stringDate
                                          .replaceAll("[", "")
                                          .replaceAll("]", "")
                                          .split(",");

                                      for (String dateString in dateStrings) {
                                        String trimmedDateString = dateString
                                            .trim()
                                            .replaceAll("'", "");
                                        DateTime dateTime =
                                            DateTime.parse(trimmedDateString);
                                        collectedDate.add(dateTime);
                                      }

                                      collectedArray.add(int.parse(
                                          _amountTextController.text));
                                      await ds.updateId(
                                          "nominal",
                                          collectedArray.toString(),
                                          token,
                                          project,
                                          "nabung",
                                          appid,
                                          args[0]);

                                      collectedDate.add(DateTime.now());

                                      await ds
                                          .updateId(
                                              "tanggal",
                                              collectedDate.toString(),
                                              token,
                                              project,
                                              "nabung",
                                              appid,
                                              args[0])
                                          .then(reloadDataGoal);
                                      collectedArray.clear();
                                      collectedDate.clear();
                                      _amountTextController.text = '';
                                      setState(() {
                                        progressIndicatorKey =
                                            ValueKey<double>(currentAmount);
                                      });
                                    }
                                  },
                                  width: 96,
                                  height: 60,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "History",
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Reguler',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200),
                                ),
                                SizedBox(height: 15),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListReporting(
                                        title: 'Saving',
                                        time:
                                            '${collectedDate[index + 1].hour}.${collectedDate[index + 1].minute}',
                                        date:
                                            '${collectedDate[index + 1].day} ${getMonthName(collectedDate[index + 1].month)} ${collectedDate[index + 1].year}',
                                        nominal: formatCurrency(
                                            collectedArray[index + 1]));
                                  },
                                  itemCount: numberOfDates - 1,
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
