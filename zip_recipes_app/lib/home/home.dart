import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart'; // Importa o FirebaseAuth
import 'package:zip_recipes_app/firebase/services/ingredient.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/home/personal_info.dart';
import 'package:zip_recipes_app/home/recipe_page.dart';
import 'package:zip_recipes_app/home/scan.dart';
import 'FoodDetails.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "User";
  int currentRecipeIndex = 0;
  // Create a sample Recipe object for testing
  final List<Recipe> recipes = [
    Recipe(
      id: '1',
      name: 'Tuna Salad',
      image: 'assets/images/icons/food.png',
      salt: '2g',
      fat: '10g',
      energy: '250kcal',
      protein: '15g',
      ingredients: [
        Ingredient(id: 'riceId', name: 'Rice', type: 'Grain'),
        Ingredient(id: 'appleId', name: 'Apple', type: 'Fruit'),
        Ingredient(id: 'lettuceId', name: 'Lettuce', type: 'Vegetable'),
      ],
      information: 'This is a simple and healthy tuna salad recipe.',
      guide: [
        'Step 1: Prepare the tuna.',
        'Step 2: Mix all the ingredients together.',
        'Step 3: Serve and enjoy!',
      ],
    ),
    
    Recipe(
      id: '2',
      name: 'Chicken Rice',
      image: 'assets/images/icons/food2.png',
      salt: '2g',
      fat: '10g',
      energy: '250kcal',
      protein: '15g',
      ingredients: [
        Ingredient(id: 'riceId', name: 'Rice', type: 'Grain'),
        Ingredient(id: 'appleId', name: 'Apple', type: 'Fruit'),
        Ingredient(id: 'lettuceId', name: 'Lettuce', type: 'Vegetable'),
      ],
      information: 'This is a simple and healthy tuna salad recipe.',
      guide: [
        'Step 1: Prepare the tuna.',
        'Step 2: Mix all the ingredients together.',
        'Step 3: Serve and enjoy!',
      ],
    ),
    ];
  

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() {
    final User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      if (user != null) {
        userName = user.email ?? user.displayName ?? "User";
      }
    });
  }

  void _changeFoodImage(int direction) {
    setState(() {
      currentRecipeIndex = (currentRecipeIndex + direction) % recipes.length;
      if (currentRecipeIndex < 0) {
        currentRecipeIndex = recipes.length - 1; // Vai para o último item
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 812,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 1),
      ),
      child: Stack(
        children: <Widget>[
          // Circular background
          Center(
            child: Container(
              width: 225,
              height: 225,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 262,
              height: 262,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(recipes[currentRecipeIndex].image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 336,
            left: 20,
            child: GestureDetector(
              onTap: () {
                _changeFoodImage(-1); // Swipe para esquerda
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/icons/back.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 336,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Abrir página de detalhes do prato
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(recipe: recipes[currentRecipeIndex],),
                  ),
                );
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/icons/forward.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 66,
            left: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalInfoPage()),
                );
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 44,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalInfoPage()),
                );
              },
              child: Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/icons/user_black.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 83,
            left: 120,
            child: Text(
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Inter',
                fontSize: 24,
                letterSpacing: -0.3333333432674408,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 220,
            child: Transform.rotate(
              angle: 90 * (math.pi / 180),
              child: Container(
                width: 12,
                height: 209,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(59)),
                  color: Color.fromRGBO(189, 219, 194, 1),
                ),
              ),
            ),
          ),
          Positioned(
            top: 84,
            left: 155,
            child: Transform.rotate(
              angle: 90 * (math.pi / 180),
              child: Container(
                width: 12,
                height: 81,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(59)),
                  color: Color.fromRGBO(134, 210, 147, 1),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 140,
            left: 261,
            child: Text(
              '1000 cal',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(134, 210, 147, 1),
                fontFamily: 'Inter',
                fontSize: 15,
                letterSpacing: -0.3333333432674408,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 60,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanPage()),
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/icons/scan.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 60,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/icons/groceries.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
