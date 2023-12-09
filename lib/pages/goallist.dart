import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:flutter/material.dart';

class GoalsList extends StatefulWidget {
  const GoalsList({Key? key, required String title}) : super(key: key);
  @override
  _GoalsList createState() => _GoalsList();
}

class _GoalsList extends State<GoalsList> {
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
            onPressed: () => Navigator.of(context).pop('home'),
          ),
          title: Text(
            "Goals List",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),

                      //TODO : BUAT KONDISI UNTUK CATEGORY GOALS (DAY, WEEK, MONTH)
                      child: Text(
                        "Day",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins-Bold',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 6), // Category Goals (DAY, WEEK, YEAR)
                    ListGoals(
                        goals: 'Check',
                        collected: 'Collected : Rp100.000',
                        target: 'Target : Rp500.000',
                        onPressed: () {},
                        imagePath: "assets/Mobil.jpg"),
                    SizedBox(height: 6), // Category Goals (DAY, WEEK, YEAR)
                    ListGoals(
                        goals: 'Check',
                        collected: 'Collected : Rp100.000',
                        target: 'Target : Rp500.000',
                        onPressed: () {},
                        imagePath: "assets/Mobil.jpg"),
                  ],
                ))
          ],
        ));
  }
}
