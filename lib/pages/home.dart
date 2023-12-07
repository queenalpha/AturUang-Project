import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/navBottom.dart';
import 'package:aturuang_project/welcoming-pages/Welcome_pages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 39,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                //Text(${"username"})
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome, fahriaqilaputra",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins-SemiBold',
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 21),
                    AspectRatio(
                      aspectRatio: 317 / 155,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor),
                        child: Stack(
                          children: [
                            Image.asset('assets/moneycard.png'),
                            Positioned(
                                top: 90,
                                left: 27,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Savings",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Poppins-Reguler',
                                              color: Colors.white)),
                                      Text("Rp20.000",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppins-Reguler',
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white)),
                                    ]))
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 47,
                          height: 47,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WelcomingPage(title: 'Back')),
                              );
                            },
                            child: Text('Goals'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 47,
                          height: 47,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WelcomingPage(title: 'Back')),
                              );
                            },
                            child: Text('Counting'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 47,
                          height: 47,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WelcomingPage(title: 'Back')),
                              );
                            },
                            child: Text('Report'),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            // SizedBox(height: 18),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   //Text(${"username"})
            //   child: Container(
            //     margin: const EdgeInsets.symmetric(horizontal: 24),
            //     height: 155,
            //     color: primaryColor,
            //   ),
            // ),
            // // AspectRatio(
            //     aspectRatio: 317 / 155,
            //     child: Container(
            //       margin: const EdgeInsets.symmetric(horizontal: 24),
            //       color: primaryColor,
            //     ))
          ],
        ),
      ),
      bottomNavigationBar: ButtomNavigation(
          currentIndex: _currentIndex,
          onTabTapped: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
