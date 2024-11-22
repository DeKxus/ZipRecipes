import 'package:flutter/material.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/home/GuidePage.dart';
import 'package:zip_recipes_app/widgets/custom_pill_button.dart';
import 'package:zip_recipes_app/widgets/custom_recipe_detail_element.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;

  const RecipePage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body:
      SingleChildScrollView(
        child: Stack(
          children: [
            // Background Circles and Decorations
            Positioned(
              top: 110,
              left: -150,
              child: Container(
                width: 700,
                height: 700,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 300,
              left: -150,
              child: Container(
                width: 700,
                height: 1000,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            // Scrollable Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60), // Space for the back button
                // Recipe Image
                Center(
                  child: Image.asset(
                    recipe.image,
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 25),
                // Recipe Title
                Center(
                  child: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Details Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRecipeDetailElement(topText: 'Salt', bottomText: recipe.salt),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Fat', bottomText: recipe.fat),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Energy', bottomText: recipe.energy),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Protein', bottomText: recipe.protein),
                  ],
                ),
                const SizedBox(height: 16),
                // Recipe Information Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Text(
                    'Recipe',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    recipe.information,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Cook It Button
                Center(
                  child: CustomPillButton(
                    text: 'COOK IT',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuidePage(
                            guide: recipe.guide,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Ingredients Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Wrap(
                    spacing: 8.0, // Space between pills horizontally
                    runSpacing: 8.0, // Space between rows
                    children: recipe.ingredients.map((ingredient) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ingredient.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
            // Fixed Back Button
            Positioned(
              top: MediaQuery.of(context).padding.top + 10, // Adjust for status bar
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}