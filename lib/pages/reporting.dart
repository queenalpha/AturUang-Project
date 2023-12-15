import 'package:aturuang_project/configuration/list_configuration.dart';
import 'package:chart_it/chart_it.dart';
import 'package:flutter/material.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins-Medium',
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

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
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 500,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/background.png',
                      // width: double.infinity,
                      // height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  AppBar(
                    leadingWidth: 100,
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

                  //Chart Start
                  Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Center(
                      child: PieChart(
                        chartStyle: RadialChartStyle(
                            backgroundColor: Colors.transparent),
                        animationDuration: const Duration(milliseconds: 500),
                        height: 350,
                        width: 350,
                        // animateOnUpdate: true,
                        // animateOnLoad: true,
                        data: PieSeries(
                          donutRadius: 70.0,
                          donutSpaceColor: Colors.transparent,
                          donutLabel: () => 'Rp100.000',
                          donutLabelStyle: ChartTextStyle(
                              textStyle: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 19,
                                  color: Colors.white)),
                          slices: <SliceData>[
                            SliceData(
                                style: SliceDataStyle(
                                  radius: 100,
                                  color: Color.fromARGB(255, 38, 243, 169),
                                  labelPosition: 150,
                                  strokeWidth: 0.0,
                                  strokeColor: Colors.white,
                                ),
                                label: (_, value) => 'Rp70.000',
                                labelStyle: ChartTextStyle(
                                    textStyle: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 18,
                                        color: Colors.white)),
                                value: 70),
                            SliceData(
                                style: SliceDataStyle(
                                  radius: 100,
                                  color: Color.fromARGB(255, 255, 84, 71),
                                  labelPosition: 150,
                                  strokeWidth: 0.0,
                                  strokeColor: Colors.white,
                                ),
                                label: (_, value) => 'Rp30.000',
                                labelStyle: ChartTextStyle(
                                    textStyle: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 18,
                                        color: Colors.white)),
                                value: 30),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //chart end

//Legend Start
                  Padding(
                    padding: const EdgeInsets.only(top: 400.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LegendItem(
                          color: const Color.fromARGB(255, 38, 243, 169),
                          label: 'Income',
                        ),
                        SizedBox(width: 20),
                        LegendItem(
                          color: Color.fromARGB(255, 255, 84, 71),
                          label: 'Spending',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Toggle Button
            Container(
              child: Center(
                child: ToggleButton(
                  isSelected: [true, false, false],
                  buttonLabels: ["All", "Income", "Spending"],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // all list
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      'All list',
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              // sengaja dikasih ini biar kalo banyak ngga overflow
              child: Container(
                child: ListReporting(
                    title: 'Salary',
                    time: '12:00',
                    date: '23 November 2023',
                    nominal: 'Rp100.000'),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: NavigationBarDemo(),
    );
  }
}
