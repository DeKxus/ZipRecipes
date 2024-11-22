import 'package:flutter/material.dart';
import 'foodListPage.dart'; // Import the dynamic FoodListPage

class GroceriesListPage extends StatelessWidget {
  const GroceriesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Column(
          children: [
            Text(
              'My Groceries',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4), // Small spacing
            Text(
              'Click on the type of food you want to see',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Layer: Others
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const FoodListPage(foodType: 'Others'),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/icons/others_groceries.png',
                    width: 80,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  const Text(
                    'Others',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Third Layer: Proteins and Dairy
            SizedBox(
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // First Pair: Proteins
                  Align(
                    alignment: const Alignment(-0.25, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListPage(foodType: 'Proteins'),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: const Alignment(0.2, 0),
                        children: [
                          Image.asset(
                            'assets/images/icons/proteins_groceries.png',
                            width: 100,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const Text(
                            'Proteins',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Second Pair: Dairy
                  Align(
                    alignment: const Alignment(0.25, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListPage(foodType: 'Dairy'),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: const Alignment(-0.2, 0),
                        children: [
                          Image.asset(
                            'assets/images/icons/dairy_groceries.png',
                            width: 100,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const Text(
                            'Dairy',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Second Layer: Grains
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const FoodListPage(foodType: 'Grains'),
                  ),
                );
              },
              child: Stack(
                alignment: const Alignment(0, -0.2),
                children: [
                  Image.asset(
                    'assets/images/icons/grains_groceries.png',
                    width: 270,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  const Text(
                    'Grains',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Layer: Vegetables
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const FoodListPage(foodType: 'Vegetables'),
                  ),
                );
              },
              child: Stack(
                alignment: const Alignment(0, -0.2),
                children: [
                  Image.asset(
                    'assets/images/icons/plants_groceries.png',
                    width: 350,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  const Text(
                    'Vegetables',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
