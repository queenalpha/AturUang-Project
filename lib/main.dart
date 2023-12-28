import 'package:Aturuang/configuration/navBottom.dart';
import 'package:Aturuang/pages/forget_password.dart';
import 'package:Aturuang/pages/goal_list.dart';
import 'package:Aturuang/pages/goals_detail.dart';
import 'package:Aturuang/pages/goals_edit.dart';
import 'package:Aturuang/pages/goals_menu.dart';
import 'package:Aturuang/pages/profile.dart';
import 'package:Aturuang/pages/counting.dart';
import 'package:Aturuang/pages/reporting.dart';
import 'package:Aturuang/welcoming-pages/Splashscreen.dart';
import 'package:Aturuang/pages/login.dart';
import 'package:Aturuang/pages/register.dart';
import 'package:Aturuang/welcoming-pages/Welcome_pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aturuang',
        home: SplashScreen(),
        routes: {
          'welcome': (context) => const WelcomingPage(),
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegistrationScreen(),
          'home': (context) => const NavigationBarDemo(),
          'goalist': (context) => const GoalsList(),
          'goals_menu': (context) => GoalsMenu(),
          'goals_edit': (context) => GoalsEdit(),
          'goals_detail': (context) => GoalsDetail(),
          'profile': (context) => const ProfilePage(),
          'counting': (context) => CountingScreen(),
          'reporting': (context) => ReportingPage(),
          'forget_password': (context) => const ForgetPassword(),
        });
  }
}
