import 'package:flutter/material.dart';
import 'package:aturuang_project/configuration/theme_config.dart';

class ReportingScreen extends StatefulWidget {
  const ReportingScreen({super.key});

  @override
  _ReportingScreenState createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  @override
  void initState() {
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
              context, 'home', (route) => false),
        ),
        title: Text(
          "Reporting Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Page Reporting',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
