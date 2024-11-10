import 'package:flutter/material.dart';

class CustomPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomPillButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: StadiumBorder(), // This makes the button pill-shaped
        backgroundColor: Colors.blue, // Customize the color as needed
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white, // Customize the text color as needed
        ),
      ),
    );
  }
}