import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final String imagePath; // Path to the image
  final double padding;    // Padding inside the button
  final double diameter;   // Diameter of the circular button
  final VoidCallback onTap; // Function to call when tapped

  const CustomCircularButton({
    Key? key,
    required this.imagePath,
    this.padding = 8.0, // default padding
    this.diameter = 60.0, // default diameter
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: diameter,
        height: diameter,
        padding: EdgeInsets.all(padding),
        decoration: const BoxDecoration(
          color: Colors.white, // White background
          shape: BoxShape.circle, // Circular shape
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain, // Adjust to contain the image within the padding
          ),
        ),
      ),
    );
  }
}