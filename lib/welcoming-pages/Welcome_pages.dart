import 'package:flutter/material.dart';
import '../configuration/theme_config.dart';
import '../configuration/roundedbutton.dart';

class WelcomingPage extends StatefulWidget {
  const WelcomingPage({Key? key, required String title}) : super(key: key);

  @override
  State<WelcomingPage> createState() => _HomePageState();
}

class _HomePageState extends State<WelcomingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/Logo_without_text.png', width: 250),
        SizedBox(height: 20),
        Text("Welcome!",
            style: TextStyle(
                fontFamily: 'Poppins-SemiBold',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10),
        Text("Start managing your money easily",
            style: TextStyle(
                fontFamily: 'Poppins-Regular',
                fontSize: 15,
                fontWeight: FontWeight.w100,
                color: Colors.white)),
        SizedBox(height: 30),
        RoundedButton(
          colour: primaryColor,
          title: "Sign In",
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          },
          width: 273,
          height: 57,
        ),
        RoundedButton(
          colour: primaryColor,
          title: "Sign Up",
          onPressed: () {
            Navigator.pushNamed(context, 'register');
          },
          width: 273,
          height: 57,
        )
      ])),
    );

    // Positioned(bottom: 200, child: Image.asset('assets/Ellipse3.png'))
  }
}
