import 'package:aturuang_project/welcoming-pages/Home.dart';
import 'package:aturuang_project/welcoming-pages/Splashscreen.dart';
import 'package:aturuang_project/login.dart';
import 'package:aturuang_project/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
          'login': (context) => const LoginScreen(),
          'register': (context) => const RegistrationScreen(),
          'home': (context) => const HomePage(),
        });
  }
}
