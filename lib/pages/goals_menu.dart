import 'package:aturuang_project/configuration/navBottom.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:flutter/material.dart';

class GoalsMenu extends StatefulWidget {
  const GoalsMenu({Key? key}) : super(key: key);
  @override
  _GoalsDetail createState() => _GoalsDetail();
}

class _GoalsDetail extends State<GoalsMenu> {
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
              context, 'home', (route) => false),
        ),
        title: Text(
          "Create Your Goals",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 59),
              child: SizedBox(
                height: 142,
                width: 142,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    color: Colors.grey[500],
                    Icons.camera_alt_sharp,
                    size: 38.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35, // Adjust the height of the box as needed
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29),
              child: Column(
                children: [
                  ToggleButton(
                      isSelected: [false, false, false],
                      buttonLabels: ["Day", "Week", "Month"]),
                  SizedBox(height: 31),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Goals name',
                    ),
                  ),
                  SizedBox(height: 31),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Target',
                    ),
                  ),
                  SizedBox(height: 44),
                  RoundedButton(
                      color: primaryColor,
                      title: 'Create',
                      onPressed: () {},
                      width: 180,
                      height: 50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
