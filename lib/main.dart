import 'package:aturuang_project/configuration/navBottom.dart';
import 'package:aturuang_project/pages/goal_list.dart';
import 'package:aturuang_project/pages/goals_detail.dart';
import 'package:aturuang_project/pages/goals_menu.dart';
import 'package:aturuang_project/pages/profile.dart';
import 'package:aturuang_project/pages/counting.dart';
import 'package:aturuang_project/pages/report_list.dart';
import 'package:aturuang_project/pages/reporting.dart';
import 'package:aturuang_project/pages/table_reporting.dart';
import 'package:aturuang_project/welcoming-pages/Splashscreen.dart';
import 'package:aturuang_project/pages/login.dart';
import 'package:aturuang_project/pages/register.dart';
import 'package:aturuang_project/welcoming-pages/Welcome_pages.dart';
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
          'goals_menu': (context) => const GoalsMenu(),
          'goals_detail': (context) => const GoalsDetail(),
          'profile': (context) => const ProfilePage(),
          'counting': (context) => const CountingScreen(),
          'reporting': (context) => const ReportingPage(),
          'reportList': (context) => const ReportList(),
          'reportTable': (context) => const ReportingTable(),
        });
  }
}
