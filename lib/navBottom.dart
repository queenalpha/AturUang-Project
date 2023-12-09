import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  ButtomNavigation({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTabTapped,
      backgroundColor: primaryColor,
      unselectedItemColor: secondaryColor,
      selectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.white),
    );
  }
}
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:flutter/material.dart';

class ButtomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  ButtomNavigation({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTabTapped,
      backgroundColor: primaryColor,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: secondaryColor),
    );
  }
}
