import 'package:aturuang_project/navBottom.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/background.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: 30,
                          child: Text(
                            'YOUR PROFILE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Poppins-SemiBold'),
                          )),
                      Positioned(
                        top: 250 - 220 / 2,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/jhondoe.png'),
                          backgroundColor: Colors.transparent,
                          radius: 140 / 2,
                        ),
                      ),

                      // Icons edit
                      Positioned(
                        top: 247,
                        // right: 150 - 70 / 250.0,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  6.0), // Atur radius sesuai keinginan
                              side: BorderSide(
                                  color: Colors.black,
                                  width: 0.7), // Atur warna dan lebar border
                            ),
                            color: Color.fromARGB(210, 255, 255, 255),
                            child: Center(
                              child: Icon(
                                Icons.edit_rounded,
                                color: const Color.fromARGB(255, 5, 116, 129),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),

              //Username
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Ramdhan Mahfuzh',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Poppins-SemiBold'),
                        ),
                      ),
                    ),

                    //Email
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'ramdhanmahfuzh74@gmail.com',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Poppins-Regular'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),

                    // Your Financial
                    Container(
                      width: double.infinity,
                      // color: Colors.green,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                            ),
                            child: Text(
                              "Your Financial",
                              style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                        ],
                      ),
                    ),

                    //financial income and outcome card
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, bottom: 7.0),
                      child: Card(
                        color: Color.fromARGB(255, 20, 165, 182),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Icon(
                                        Icons.arrow_upward_rounded,
                                        size: 50,
                                        color:
                                            Color.fromARGB(255, 38, 243, 169),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          'Income',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins-Regular',
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          'RP 50.000',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins-SemiBold',
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Icon(
                                        Icons.arrow_downward_rounded,
                                        size: 50,
                                        color: Color.fromARGB(255, 255, 85, 71),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          'Spending',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins-Regular',
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          'RP 50.000',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins-SemiBold',
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //// three button below
                    Padding(
                      padding: EdgeInsets.only(
                          top: 50, left: 12, right: 12, bottom: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Card(
                              color: Color.fromARGB(255, 20, 165, 182),
                              child: ListTile(
                                leading: Image.asset('assets/Mygoals.png'),
                                title: Text(
                                  'My Goals',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins-Medium',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Card(
                              color: Color.fromARGB(255, 20, 165, 182),
                              child: ListTile(
                                leading:
                                    Image.asset('assets/delete account.png'),
                                title: Text(
                                  'Delete Account',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins-Medium',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Card(
                              color: Color.fromARGB(255, 20, 165, 182),
                              child: ListTile(
                                leading: Image.asset('assets/logout.png'),
                                title: Text(
                                  'Log Out',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins-Medium',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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
