<<<<<<< HEAD
=======
import 'package:aturuang_project/pages/Home.dart';
>>>>>>> fb6ef60f247b0bc6aefee44d036ef0ea53869a30
import 'package:aturuang_project/pages/goalist.dart';
import 'package:aturuang_project/pages/profile.dart';
import 'package:aturuang_project/welcoming-pages/Splashscreen.dart';
import 'package:aturuang_project/pages/login.dart';
import 'package:aturuang_project/pages/register.dart';
<<<<<<< HEAD
import 'package:aturuang_project/login.dart';
=======
import 'package:aturuang_project/welcoming-pages/Welcome_pages.dart';
>>>>>>> fb6ef60f247b0bc6aefee44d036ef0ea53869a30
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
          'welcome': (context) => const WelcomingPage(title: 'Welcome'),
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegistrationScreen(),
          'home': (context) => const HomePage(),
          'profile': (context) => const ProfilePage(),
          'goalist': (context) => const GoalsList(title: "Goals List"),
        });
  }
}
