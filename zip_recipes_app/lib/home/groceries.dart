import 'package:flutter/material.dart';
import 'foodListPage.dart'; // Import the dynamic FoodListPage

class GroceriesListPage extends StatelessWidget {
  const GroceriesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
        title: const Text(
          'My Groceries',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Bottom Layer: Vegetables
            Positioned(
              bottom: 200,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FoodListPage(foodType: 'Vegetables'),
                    ),
                  );
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
              bottom: 290,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodListPage(foodType: 'Grains'),
                    ),
                  );
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
              bottom: 380,
              left: 90,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodListPage(foodType: 'Proteins'),
                    ),
                  );
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
              bottom: 380,
              right: 90,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodListPage(foodType: 'Dairy'),
                    ),
                  );
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
              bottom: 470,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodListPage(foodType: 'Others'),
                    ),
                  );
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
          ],
        ),
      ),
    );
  }
}
