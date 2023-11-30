import 'package:aturuang_project/Welcoming%20pages/Splashscreen.dart';
import 'package:flutter/material.dart';
import '../Welcoming pages/Splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aturuang',
        home: SplashScreen());
  }
}
