import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(242, 242, 242, 242),
  hintText: 'Fill A value',
  hintStyle: TextStyle(
      color: Colors.grey, fontFamily: 'Poppins-Reguler', fontSize: 12),
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

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour,
      required this.title,
      required this.onPressed,
      required this.width,
      required this.height});
  final Color colour;
  final String title;
  final VoidCallback onPressed;

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(8.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: width,
          height: height,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final List<bool> isSelected;
  final List<String> buttonLabels;

  ToggleButton({
    required this.isSelected,
    required this.buttonLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: ToggleButtons(
        isSelected: isSelected,
        selectedColor: Colors.black,
        fillColor: secondaryColor,
        color: Colors.black,
        children: List.generate(
          buttonLabels.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Text(
              buttonLabels[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
