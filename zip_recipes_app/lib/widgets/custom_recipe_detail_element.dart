import 'package:flutter/material.dart';

class CustomRecipeDetailElement extends StatelessWidget {
  final String topText;
  final String bottomText;

  // Constructor to accept the text
  const CustomRecipeDetailElement({
    Key? key,
    required this.topText,
    required this.bottomText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55, 
      height: 85, 
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(50), // Makes the shape pill-like
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top Text
          Text(
            topText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8), 
          // Bottom Text
          Container(
            width: 40, 
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50), 
            ),
            child: Center(
              child: Text(
                bottomText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}