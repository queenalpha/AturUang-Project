import 'package:aturuang_project/configuration/navBottom.dart';
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
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: const Column(
            children: [],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarDemo(),
    );
  }
}
