import 'package:flutter/material.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
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
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Circle in the background
            Positioned(
              top: 110, // Adjust as needed to place the circle
              left: -150, // Adjust as needed to place the circle
              child: Container(
                width: 700, // Diameter of the circle
                height: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              top: 300, // Adjust as needed to place the circle
              left: -150, // Adjust as needed to place the circle
              child: Container(
                width: 700, // Diameter of the circle
                height: 1000,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),

            // Main content
            Column(
              children: [
                const SizedBox(height: 25),
                //recipe image
                 Image.asset(
                  recipe.image,
                  width: 170,
                  height: 170,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 25),
                    
                //title
                Text(
                  recipe.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                    
                //details
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      child: const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRecipeDetailElement(topText: 'Salt', bottomText: recipe.salt),
                    SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Fat', bottomText: recipe.fat),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Energy', bottomText: recipe.energy),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Protein', bottomText: recipe.protein),
                  ],
                ),
                
                    
                //recipe information
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      child: const Text(
                        'Recipe',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Text(
                    recipe.information,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                //cook it button
                CustomPillButton(
                  text: 'COOK IT',
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const RecipeGuidePage()),
                    // );
                  },
                ),
                const SizedBox(height: 8),

                //list of ingredients
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      child: const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
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
                          color: Color(0xFFD9D9D9),
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
          ],
        ),
      ),
    );
  }
}
