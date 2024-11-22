import 'package:flutter/material.dart';

class CustomPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final double horizontalPadding; // New property for horizontal padding
  final double verticalPadding; // New property for vertical padding
  final double fontSize; // New property for text font size

  const CustomPillButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor = const Color(0xFF86D293),
    this.textColor = Colors.white,
    this.horizontalPadding = 40.0, // Default value for horizontal padding
    this.verticalPadding = 10.0, // Default value for vertical padding
    this.fontSize = 16.0, // Default value for font size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        shape: const StadiumBorder(),
        backgroundColor: buttonColor,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}