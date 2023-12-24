import 'package:flutter/material.dart';

import '../configuration/list_configuration.dart';
import '../configuration/theme_config.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);
  @override
  _ReportList createState() => _ReportList();
}

class _ReportList extends State<ReportList> {
  String selectedFilter = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, 'reporting', (route) => false),
        ),
        title: Text("Reporting", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // all list
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All list',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            _buildFilterDropdown(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, 'reportTable'),
                        child: ListReporting(
                          title: 'Salary',
                          time: '12:00',
                          date: '23 November 2023',
                          nominal: 'Rp100.000',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // VALUE FILTER
  Widget _buildFilterDropdown() {
    return PopupMenuButton(
      icon: Icon(
        Icons.filter_list,
        color: Colors.black,
      ),
      // color: Colors.black,
      onSelected: (value) {
        _selectFilterOption(value.toString());
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'Option 1',
          child: Row(
            children: [
              Text('Option 1'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Option 2',
          child: Row(
            children: [
              Text('Option 2'),
            ],
          ),
        ),
      ],
    );
  }

  void _selectFilterOption(String option) {
    setState(() {
      selectedFilter = option;
    });
  }
}
