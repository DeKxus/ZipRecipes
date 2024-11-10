import 'package:flutter/material.dart';

class CustomFavoriteElement extends StatelessWidget {
  final String imagePath;
  final String recipeName;

  const CustomFavoriteElement({
    Key? key,
    required this.imagePath,
    required this.recipeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Round Container on the left
          Container(
            width: 70, 
            height: 70, 
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
          
          // Container holding the recipe name
          Expanded(
            child: Container(
              height: 70, 
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(100), 
              ),
              child: Center(
                child: Text(
                  recipeName,
                  style: TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 18.0,
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