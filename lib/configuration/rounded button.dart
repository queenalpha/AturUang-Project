import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour, required this.title, required this.onPressed, required this.width, required this.height});
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
          minWidth: width ?? 200.0,
          height: height ?? 42.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
