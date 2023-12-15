import 'package:flutter/material.dart';
import 'package:aturuang_project/configuration/theme_config.dart';
import 'package:aturuang_project/pages/reporting.dart';

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
  final List<bool> isSelected;
  final List<String> buttonLabels;

  ToggleButton({required this.isSelected, required this.buttonLabels});
}

class _ToggleButtonState extends State<ToggleButton> {
  // Initial state

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      child: Card(
        color: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        child: ToggleButtons(
          isSelected: widget.isSelected,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0;
                  buttonIndex < widget.isSelected.length;
                  buttonIndex++) {
                widget.isSelected[buttonIndex] = buttonIndex == index;
              }
            });
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
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour, required this.title, required this.onPressed});
  final Color colour;
  final String title;
  final VoidCallback onPressed;
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
          minWidth: 200.0,
          height: 50.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
