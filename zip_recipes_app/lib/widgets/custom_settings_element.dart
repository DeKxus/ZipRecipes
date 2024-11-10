import 'package:flutter/material.dart';

class CustomSettingsElement extends StatelessWidget {
  final String imagePath;
  final String labelText;

  // Constructor with optional parameters
  const CustomSettingsElement({
    Key? key,
    required this.imagePath,
    required this.labelText, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          // Round Container on the left
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 16),
          // Container holding the label text
          Expanded(
            child: Container(
              height: 90,
              child: Center(
                child: Text(
                  labelText,
                  style: const TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}