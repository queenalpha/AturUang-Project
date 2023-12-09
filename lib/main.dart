import 'package:aturuang_project/pages/Home.dart';
import 'package:aturuang_project/pages/profile.dart';
import 'package:aturuang_project/welcoming-pages/Splashscreen.dart';
import 'package:aturuang_project/pages/pages/login.dart';
import 'package:aturuang_project/pages/pages/register.dart';
import 'package:aturuang_project/welcoming-pages/Welcome_pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//
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
        initialRoute: '',
        routes: {
          'welcome': (context) => const WelcomingPage(title: 'Welcome'),
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegistrationScreen(),
          'home': (context) => const HomePage(),
          'goalist': (context) => const GoalsList(title: "Goals List"),
          'profile': (context) => const ProfilePage(),
        });
  }
}
