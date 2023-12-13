import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../welcoming-pages/Welcome_pages.dart';
import '../configuration/theme_config.dart';

int? initScreen;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    GotonavigateToHome();
  }

  Future<void> GotonavigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = await preferences.getInt('initScreen');
    await preferences.setInt('initScreen', 1);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: initScreen == 0 || initScreen == null
            ? (context) => onBoardingPage()
            : (context) => const WelcomingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/Logo Aturuang.png', width: 200)])),
    );
  }
}
