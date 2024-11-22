import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart'; // Importa o FirebaseAuth
import 'package:zip_recipes_app/firebase/services/ingredient.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/home/personal_info.dart';
import 'package:zip_recipes_app/home/recipe_page.dart';
import 'package:zip_recipes_app/home/scan.dart';
import 'package:zip_recipes_app/home/groceries.dart';

import 'FoodDetails.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _pageController = PageController(initialPage: 0);
  double _dragOffset = 0.0; // Controla o deslocamento da imagem

  String userName = "User";
  int currentRecipeIndex = 0;
  // Create a sample Recipe object for testing
  final List<Recipe> recipes = [
    Recipe(
      id: '1',
      name: 'Tuna Salad',
      image: 'assets/images/food_images/SaladaAtum.png',
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
        RecipeStep(description: 'Preheat the oven to 350°F (175°C).'),
        RecipeStep(description: 'Mix dry ingredients together.', timer: 30),
        RecipeStep(description: 'Add wet ingredients and mix until smooth.', timer: 30),
        RecipeStep(description: 'Bake for 30 minutes.', timer: 30),
        RecipeStep(description: 'Let it cool for 15 minutes.', timer: 15),
      ],
    ),

    Recipe(
      id: '2',
      name: 'Chicken Salad',
      image: 'assets/images/food_images/ChickenSalad.png',
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
        RecipeStep(description: 'Preheat the oven to 350°F (175°C).'),
        RecipeStep(description: 'Mix dry ingredients together.', timer: 30),
        RecipeStep(description: 'Add wet ingredients and mix until smooth.',timer: 30),
        RecipeStep(description: 'Bake for 30 minutes.', timer: 30),
        RecipeStep(description: 'Let it cool for 15 minutes.', timer: 15),
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
      _dragOffset = 0; // Restaura o deslocamento ao mudar de imagem
      if (direction == -1) {
        currentRecipeIndex = (currentRecipeIndex + 1) % recipes.length;
      } else if (direction == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipePage(recipe: recipes[currentRecipeIndex]),
          ),
        );
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
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragOffset += details.primaryDelta ?? 0; // Atualiza o deslocamento horizontal
              });
            },
            onHorizontalDragEnd: (details) {
              setState(() {
                if ((details.primaryVelocity ?? 0).abs() > 300) {
                  // Detecta swipe rápido
                  if (details.primaryVelocity! > 0) {
                    _changeFoodImage(1); // Swipe para a direita
                  } else {
                    _changeFoodImage(-1); // Swipe para a esquerda
                  }
                } else {
                  // Retorna a imagem ao centro
                  _dragOffset = 0;
                }
              });
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
                crossAxisAlignment: CrossAxisAlignment.center, // Centraliza horizontalmente
                children: [
                  const SizedBox(height: 45),
                  Transform.translate(
                    offset: Offset(_dragOffset, 20), // Baixa a imagem ajustando a posição
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(recipes[currentRecipeIndex].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50), // Reduz a distância entre a imagem e o título
                  Text(
                    recipes[currentRecipeIndex].name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GroceriesListPage()), // Replace with your groceries page widget
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