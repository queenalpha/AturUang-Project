import 'dart:convert';
import 'dart:io';
import 'package:aturuang_project/configuration/api_configuration.dart';
import 'package:aturuang_project/configuration/roundedbutton.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/utils/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class GoalsMenu extends StatefulWidget {
  GoalsMenu({Key? key}) : super(key: key);
  List<bool> isSelected = [false, false, false];
  List<String> buttonLabels = ['Day', 'Week', 'Month'];
  String selectedOption = 'a';
  @override
  _GoalsDetail createState() => _GoalsDetail();
}

class _GoalsDetail extends State<GoalsMenu> {
  DateTime now = DateTime.now();
  String profpic = "-";
  late ValueNotifier<int> _notifier;
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  //Profic
  File? image;
  String? imageProfpic;

  Future pickImage() async {
    try {
      var picked = await FilePicker.platform.pickFiles(withData: true);

      if (picked != null) {
        var response = await ds.upload(token, project,
            picked.files.first.bytes!, picked.files.first.extension.toString());

        var file = jsonDecode(response);
        profpic = file['file_name'];

        _notifier.value++;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  final _goalsTextController = TextEditingController();
  final _targetTextController = TextEditingController();

  final _focusGoals = FocusNode();
  final _focusTarget = FocusNode();

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
              context, 'home', (route) => false),
        ),
        title: Text(
          "Create Your Goals",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 59),
              child: GestureDetector(
                onTap: () => pickImage(),
                child: SizedBox(
                  height: 142,
                  width: 142,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      color: Colors.grey[500],
                      Icons.camera_alt_sharp,
                      size: 38.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35, // Adjust the height of the box as needed
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    child: Card(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                      child: ToggleButtons(
                        isSelected: widget.isSelected,
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < widget.isSelected.length;
                                buttonIndex++) {
                              widget.isSelected[buttonIndex] =
                                  widget.isSelected[buttonIndex] = false;
                            }
                            widget.isSelected[index] = true;
                          });
                          if (widget.isSelected.contains(true)) {
                            widget.selectedOption = widget
                                .buttonLabels[widget.isSelected.indexOf(true)];
                          } else {
                            widget.selectedOption = '';
                          }
                        },
                        selectedColor: secondaryColor,
                        fillColor: secondaryColor,
                        children: List.generate(
                          widget.buttonLabels.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              widget.buttonLabels[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 31),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Goals name',
                    ),
                    focusNode: _focusGoals,
                    controller: _goalsTextController,
                  ),
                  SizedBox(height: 31),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Target',
                    ),
                    focusNode: _focusTarget,
                    controller: _targetTextController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 44),
                  RoundedButton(
                      color: primaryColor,
                      title: 'Create',
                      onPressed: () async {
                        _focusGoals.unfocus();
                        _focusTarget.unfocus();

                        await ds.insertNabung(
                            appid,
                            '-',
                            _goalsTextController.text,
                            _targetTextController.text,
                            widget.selectedOption,
                            "[0]",
                            currentUser!.uid,
                            now.toString());
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      },
                      width: 180,
                      height: 50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
