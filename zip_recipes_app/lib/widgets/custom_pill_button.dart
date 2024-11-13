import 'package:flutter/material.dart';

class CustomPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  const CustomPillButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor = const Color(0xFF86D293), 
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: StadiumBorder(), 
        backgroundColor: buttonColor, 
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor, 
        ),
      ),
    );
  }
}