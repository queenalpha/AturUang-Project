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
                      ),
                      child: Stack(
                        children: [
                          Image.asset('assets/moneycard.png'),
                          Positioned(
                              top: 90,
                              left: 27,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 47,
                                  width: 47,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: primaryColor,
                                  ),
                                  child: Image.asset(
                                    "assets/IconGoals.png",
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text("Goals",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Reguler',
                                      fontSize: 10,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Flexible(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 47,
                                  width: 47,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: primaryColor,
                                  ),
                                  child: Image.asset(
                                    "assets/IconCounting.png",
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text("Counting",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Reguler',
                                      fontSize: 10,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Flexible(
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 47,
                                  width: 47,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: primaryColor,
                                  ),
                                  child: Image.asset(
                                    "assets/IconReporting.png",
                                    width: 16,
                                    height: 16,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text("Reporting",
                                    style: TextStyle(
                                      fontFamily: 'Poppins-Reguler',
                                      fontSize: 10,
                                    )),
                                // ElevatedButton(onPressed: onPressed {}, child: child)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 29),
                  Container(
                    width: 330,
                    height: 3,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 49,
                        height: 49,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[900]!,
                          ),
                          color: cardGrey,
                        ),
                        child: Icon(
                          Icons.arrow_upward_sharp,
                          size: 34.0,
                          color: arrowUp,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("Income",
                          //     style: TextStyle(
                          //         fontFamily: 'Poppins-Reguler',
                          //         fontSize: 12,
                          //         color: secondaryColor)),
                          // SizedBox(height: 8),
                          Text("Income",
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: secondaryColor,
                              )),
                          SizedBox(height: 8),
                          Text("Rp50.000",
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      SizedBox(width: 28),
                      Container(
                        width: 49,
                        height: 49,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[900]!,
                          ),
                          color: cardGrey,
                        ),
                        child: Icon(
                          Icons.arrow_downward_sharp,
                          size: 34.0,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("Income",
                          //     style: TextStyle(
                          //         fontFamily: 'Poppins-Reguler',
                          //         fontSize: 12,
                          //         color: secondaryColor)),
                          // SizedBox(height: 8),
                          Text("Spending",
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: secondaryColor,
                              )),
                          SizedBox(height: 8),
                          Text("Rp30.000",
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
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
