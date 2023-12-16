// import 'dart:convert';

// import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
// import 'package:aturuang_project/models/nabung_model.dart';
// import 'package:aturuang_project/utils/restapi.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class GoalsDetail extends StatefulWidget {
  const GoalsDetail({Key? key}) : super(key: key);
  @override
  _GoalsDetail createState() => _GoalsDetail();
}

class _GoalsDetail extends State<GoalsDetail> {
  //bikin varibale target tabungan dan progress saat ini
  double targetAmount = 100000.0;
  double currentAmount = 20000.0;

  @override
  Widget build(BuildContext context) {
    // bikin variable total progress
    double progress_savings = currentAmount / targetAmount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Goals Detail",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 204,
                width: double.infinity,
                child: Image.asset(
                  "assets/Meat.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 137,
                left: 25,
                child: Row(
                  children: [
                    Text(
                      "Meat Stock",
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
                ),
              ),
            ],
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
                        color: primaryColor, // Use your desired color
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 19,
                        vertical: 14,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Target"),
                              Text("Rp${targetAmount.toStringAsFixed(0)}"),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: 314,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[400],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: progress_savings,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    secondaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(decoration: formSavingAdd('Rp')),
                    ),
                    SizedBox(width: 8),
                    RoundedButton(
                      color: primaryColor, // Use your desired color
                      title: 'Add',
                      onPressed: () {},
                      width: 96,
                      height: 40,
                    ),
                  ],
                ),
                SizedBox(height: 41),
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
                    ListReporting(
                        title: 'Savings',
                        time: '12.00',
                        date: '23 Novmber 2023',
                        nominal: 'Rp25.000')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
