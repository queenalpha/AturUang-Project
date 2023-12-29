import 'dart:convert';
import 'package:Aturuang/configuration/api_configuration.dart';
import 'package:Aturuang/configuration/roundedbutton.dart';
import 'package:Aturuang/configuration/theme_config.dart';
import 'package:Aturuang/utils/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class GoalsMenu extends StatefulWidget {
  GoalsMenu({Key? key}) : super(key: key);
  List<bool> isSelected = [true, false, false];
  List<String> buttonLabels = ['Day', 'Week', 'Month'];
  String selectedOption = 'a';
  @override
  _GoalsDetail createState() => _GoalsDetail();
}

class _GoalsDetail extends State<GoalsMenu> {
  DateTime now = DateTime.now();
  String profpic = "-";
  DataService ds = DataService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  // String? imagePath;
  // String? imageBytes;
  // MemoryImage? selectedImage;
  // String? extImage;
  FilePickerResult? picked;

  Future pickImage() async {
    try {
      picked = await FilePicker.platform.pickFiles(withData: true);

      if (picked != null && picked!.files.isNotEmpty) {
        setState(() {
          //refresh UI
          // imageBytes = picked!.files.single.path;
          // selectedImage = MemoryImage(imageBytes!);
          // extImage = picked!.files.first.extension.toString();
        });
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static String? isNotEmptyValidate(
      {required String? value, required String? field}) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Isi terlebih dahulu ${field} tersebut!';
    }

    return null;
  }

  Future<Widget> uploadDataAndImage() async {
    print("picked: ${picked}");
    if (picked != null && picked!.files.isNotEmpty) {
      var response = await ds.upload(token, project, picked!.files.first.bytes!,
          picked!.files.first.extension.toString());
      var file = jsonDecode(response);
      await ds.insertNabung(
        appid,
        file['file_name'],
        _goalsTextController.text,
        _targetTextController.text,
        widget.selectedOption,
        "[0]",
        currentUser!.uid,
        "[${now}]",
      );
      print("file name: ${file['file_name']}");
    } else {
      await ds.insertNabung(
        appid,
        '651bc4399b493f4b9fe24867_656839c21e965436b80825ca_lKWoiGMCrTsQxUxhRCATwApDPP6jFGWQ.jpg',
        _goalsTextController.text,
        _targetTextController.text,
        widget.selectedOption,
        "[0]",
        currentUser!.uid,
        "[${now}]",
      );
    }
    return created();
  }

  Widget created() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 36),
        child: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your goals has been\ncreated on goals list",
                  style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  )),
              SizedBox(height: 8),
            ],
          ),
        ]));
  }

  final _goalsTextController = TextEditingController();
  final _targetTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isAtLeastOneSelected = false;

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
                    backgroundImage:
                        MemoryImage(picked?.files.first.bytes ?? Uint8List(0)),
                    child: picked == null
                        ? Icon(
                            color: Colors.grey[500],
                            Icons.camera_alt_sharp,
                            size: 38.5,
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            Text(profpic),
            SizedBox(
              height: 35,
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
                          isAtLeastOneSelected =
                              widget.isSelected.contains(true);
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Goals name',
                          ),
                          validator: (value) => isNotEmptyValidate(
                              value: value, field: "Goals name"),
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
                          validator: (value) =>
                              isNotEmptyValidate(value: value, field: 'Target'),
                        ),
                        SizedBox(height: 44),
                        RoundedButton(
                          color: primaryColor,
                          title: 'Create',
                          onPressed: () async {
                            _focusGoals.unfocus();
                            _focusTarget.unfocus();
                            if (_formKey.currentState?.validate() ?? false) {
                              if (widget.isSelected.contains(true)) {
                                widget.selectedOption = widget.buttonLabels[
                                    widget.isSelected.indexOf(true)];
                                await uploadDataAndImage();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'home', (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Pilih salah satu periode!'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Lengkapi Seluruh data!'),
                                ),
                              );
                            }
                          },
                          width: 180,
                          height: 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
