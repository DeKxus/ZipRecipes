import 'package:flutter/material.dart';

class GroceriesListPage extends StatelessWidget {
  const GroceriesListPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Bottom Layer: Vegetables
            Positioned(
              bottom: 200, // Moved upwards from 50
              child: GestureDetector(
                onTap: () {
                  print("Vegetables tapped");
                },
                child: Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(134, 210, 147, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Vegetables',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Second Layer: Grains
            Positioned(
              bottom: 290, // Moved upwards from 140
              child: GestureDetector(
                onTap: () {
                  print("Grains tapped");
                },
                child: Container(
                  width: 240,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 212, 136, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Grains',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Third Layer: Proteins (Left)
            Positioned(
              bottom: 380, // Moved upwards from 230
              left: 90,
              child: GestureDetector(
                onTap: () {
                  print("Proteins tapped");
                },
                child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 170, 171, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Proteins',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Third Layer: Dairy (Right)
            Positioned(
              bottom: 380, // Moved upwards from 230
              right: 90,
              child: GestureDetector(
                onTap: () {
                  print("Dairy tapped");
                },
                child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(209, 232, 247, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Dairy',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Top Layer: Others
            Positioned(
              bottom: 470, // Moved upwards from 320
              child: GestureDetector(
                onTap: () {
                  print("Others tapped");
                },
                child: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(221, 175, 247, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Others',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Title
            const Positioned(
              top: 100, // Slightly adjusted upwards from 80
              child: Text(
                'My Groceries',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}