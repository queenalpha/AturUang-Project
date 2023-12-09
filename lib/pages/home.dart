import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/navBottom.dart';
import 'package:aturuang_project/pages/goalist.dart';
import 'package:aturuang_project/welcoming-pages/Welcome_pages.dart';
import 'package:flutter/material.dart';

// ....
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variable untuk bottomNav
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 39,
            ),

            // Heading Area
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

                  // Menu APPS Area
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                        "assets/IconGoals.png",
                                        height: 35,
                                        width: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text("Goals"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Column(
                          children: [
                            GestureDetector(
                              // Navigation to financial counting
                              onTap: () {},
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                        "assets/IconCounting.png",
                                        height: 35,
                                        width: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text("Counting"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        Column(
                          children: [
                            GestureDetector(
                              // Navigation to reporting
                              onTap: () {},
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      color: primaryColor,
                                      padding: EdgeInsets.all(8),
                                      child: Image.asset(
                                        "assets/IconReporting.png",
                                        height: 35,
                                        width: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text("Reporting"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 29),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 3,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Financial Display Report Area
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.13,
                        height: screenWidth * 0.13,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                          border: Border.all(
                            width: screenWidth * 0.002,
                            color: Colors.grey[900]!,
                          ),
                          color: cardGrey,
                        ),
                        child: Icon(
                          Icons.arrow_upward_sharp,
                          size: screenWidth * 0.10,
                          color: arrowUp,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Income",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: screenWidth * 0.033,
                              fontWeight: FontWeight.w300,
                              color: secondaryColor,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          //Ambil data INCOME dari API
                          Text(
                            "Rp50.000",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.23),
                      Container(
                        width: screenWidth * 0.13,
                        height: screenWidth * 0.13,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                          border: Border.all(
                            width: screenWidth * 0.002,
                            color: Colors.grey[900]!,
                          ),
                          color: cardGrey,
                        ),
                        child: Icon(
                          Icons.arrow_downward_sharp,
                          size: screenWidth * 0.10,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Spending",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: screenWidth * 0.033,
                              fontWeight: FontWeight.w300,
                              color: secondaryColor,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          // ambil data spending dari API
                          Text(
                            "Rp30.000",
                            style: TextStyle(
                              fontFamily: 'Poppins-Bold',
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),

                  // GoalList Area
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // batasi Item countnya 2 atau 3
                      Text("Goals List",
                          style: TextStyle(
                              fontFamily: 'Poppins-Reguler',
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: primaryColor)),
                      SizedBox(height: 9),
                      ListGoals(
                          goals: 'Check',
                          collected: 'Rp100.000',
                          target: 'Rp500.000',
                          onPressed: () {},
                          imagePath: "assets/Mobil.jpg"),

                      SizedBox(height: 9),
                      ListGoals(
                          goals: 'Check',
                          collected: 'Rp100.000',
                          target: 'Rp500.000',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalsList(
                                        title: 'goalist',
                                      )),
                            );
                          },
                          imagePath: "assets/Mobil.jpg"),

                      SizedBox(height: 9),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'goalist');
                          },
                          child: Text(
                            "See More",
                            style: TextStyle(
                              fontFamily: 'Poppins-Reguler',
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
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
