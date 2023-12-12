// import 'package:flutter/material.dart';
// import 'package:aturuang_project/configuration/theme_config.dart';

// class ReportingScreen extends StatefulWidget {
//   const ReportingScreen({super.key});

//   @override
//   _ReportingScreenState createState() => _ReportingScreenState();
// }

// class _ReportingScreenState extends State<ReportingScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: primaryColor,
//           ),
//           onPressed: () => Navigator.pushNamedAndRemoveUntil(
//               context, 'home', (route) => false),
//         ),
//         title: Text(
//           "Reporting Page",
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           'Page Reporting',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

import 'package:aturuang_project/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ReportingPage extends StatefulWidget {
  const ReportingPage({Key? key}) : super(key: key);
  @override
  _ReportingPageState createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 450,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/background.png',
                      // width: double.infinity,
                      // height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  AppBar(
                    leadingWidth: 50,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      },
                    ),
                    // Warna latar belakang transparan
                    backgroundColor: Colors.transparent,
                    // Atur elevasi ke 0 untuk menghilangkan bayangan AppBar
                    elevation: 0,
                    centerTitle: true,
                    title: Text('Reporting',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(95.0),
                    child: Positioned(
                      top: 450 / 2 - 120,
                      child: Center(
                        child: new CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 30.0,
                          animation: true,
                          percent: 0.6,
                          footer: new Text(
                            "Total",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                                height: 3.5),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor:
                              const Color.fromARGB(255, 38, 243, 169),
                          backgroundColor: Color.fromARGB(255, 255, 84, 71),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
