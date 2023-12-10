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
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  String formatCurrency(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0, // Jumlah digit di belakang koma
    );

    return formatter.format(amount);
  }

  int parseAndConvert(String input) {
    // Menghapus tanda kurung siku dan mengonversi menjadi string murni
    String cleanString = input.replaceAll('[', '').replaceAll(']', '');

    // Mengubah string menjadi nilai integer
    int result = int.tryParse(cleanString) ?? 0;

    return result;
  }

  Future<List<Map<String, dynamic>>> selectAllTabungan() async {
    try {
      List<dynamic> data = jsonDecode(await ds.selectWhere(
          token, project, 'nabung', appid, 'user_id', currentUser?.uid ?? ''));

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      print('Error during selectAllTabungan: $e');
      return [];
    }
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
      body: FutureBuilder(
        future: selectAllTabungan(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>>? data = snapshot.data;
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  List<int> collected = [];
                  collected.add(jsonDecode(data[index]['nominal'])
                      .cast<int>()
                      .fold(0,
                          (previousValue, element) => previousValue + element));
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 29),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  "Day",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Poppins-Bold',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      6), // Category Goals (DAY, WEEK, YEAR)
                              ListGoals(
                                  goals: '${data[index]['nama']}',
                                  collected:
                                      '${parseAndConvert(collected.toString())}',
                                  target: '${data[index]['target']}',
                                  onPressed: () {},
                                  imagePath: "assets/Mobil.jpg"),
                              SizedBox(height: 6),
                            ],
                          ))
                    ],
                  );
                });
          }
        },
      ),
    );
  }
}
