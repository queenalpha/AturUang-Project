import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(242, 242, 242, 242),
  hintStyle: TextStyle(
      color: Colors.grey, fontFamily: 'Poppins-Regular', fontSize: 12),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 20, 165, 182), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

class CountingScreen extends StatefulWidget {
  const CountingScreen({super.key});

  @override
  _CountingScreenState createState() => _CountingScreenState();
}

class _CountingScreenState extends State<CountingScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _dateTextController = TextEditingController();
  final _financialcategoryTextController = TextEditingController();
  final _AmountTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();

  final _focusdate = FocusNode();
  final _focusfinancial = FocusNode();
  final _focusamount = FocusNode();
  final _focusdescription = FocusNode();

  List<String> financialCategory = ['Salary', 'Invest', 'Daily', 'Custom'];
  String? selectedFinancialCategory;

  bool isCustomCategory = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
            size: 25,
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, 'home', (route) => false),
        ),
        title: Text(
          "Counting Page",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Poppins-SemiBold'),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            ToggleButton(
                isSelected: [true, false],
                buttonLabels: ['Income', 'Spending']),
            SizedBox(
              height: 23,
            ),
            Container(),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 29, left: 29),
                    child: TextFormField(
                      controller: _dateTextController,
                      focusNode: _focusdate,
                      keyboardType: TextInputType.datetime,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'DD - MM - YY'),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 29, left: 29),
                    child: DropdownButtonFormField<String>(
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Financial Category',
                      ),
                      value: selectedFinancialCategory,
                      items: [
                        ...financialCategory.map((Category) {
                          return DropdownMenuItem<String>(
                            value: Category,
                            child: Text(Category),
                          );
                        }),
                        if (isCustomCategory &&
                            _financialcategoryTextController.text.isNotEmpty)
                          DropdownMenuItem<String>(
                            value: _financialcategoryTextController.text,
                            child: Text(_financialcategoryTextController.text),
                          )
                      ],
                      onChanged: (value) {
                        setState(
                          () {
                            selectedFinancialCategory = value;
                            if (value == 'Custom') {
                              _showCustomCategoryDialog();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  // if (isCustomCategory)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  //     child: TextFormField(
                  //       controller: _financialcategoryTextController,
                  //       focusNode: _focusfinancial,
                  //       keyboardType: TextInputType.text,
                  //       decoration: kTextFieldDecoration.copyWith(
                  //         hintText: 'Custom Financial Category',
                  //       ),
                  //       onChanged: (value) {
                  //         // Handle the changes in the custom category input
                  //       },
                  //     ),
                  //   ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 29, left: 29),
                    child: TextFormField(
                      controller: _AmountTextController,
                      focusNode: _focusamount,
                      keyboardType: TextInputType.number,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Amount',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 8, right: 29, left: 29),
                      child: TextFormField(
                        controller: _descriptionTextController,
                        focusNode: _focusdescription,
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 6,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Description',
                        ),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            RoundedButton(colour: primaryColor, title: "Save", onPressed: () {})
          ],
        ),
      ),
    );
  }

  void _showCustomCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Custom Financial Category'),
          content: TextField(
            controller: _financialcategoryTextController,
            decoration: kTextFieldDecoration.copyWith(
              hintText: 'Enter custom category',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String newCategory = _financialcategoryTextController.text;
                  // Insert new category above 'Custom'
                  financialCategory.insert(
                      financialCategory.length - 1, newCategory);
                  selectedFinancialCategory = newCategory;
                });
                Navigator.pop(context);
              },
              child: Text('Add to Dropdown'),
            ),
          ],
        );
      },
    );
  }
}
