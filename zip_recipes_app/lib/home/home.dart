import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zip_recipes_app/home/personal_info.dart';
import 'package:zip_recipes_app/home/scan.dart';
import 'FoodDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "User";
  int currentFoodIndex = 0;
  double dragDistance = 0; // Distância percorrida pelo swipe
  final List<String> foodImages = [
    'assets/images/icons/food.png',
    'assets/images/icons/food2.png'
  ];
  final List<String> foodNames = ["Pizza", "Burger"];

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
      currentFoodIndex = (currentFoodIndex + direction) % foodImages.length;
      if (currentFoodIndex < 0) {
        currentFoodIndex = foodImages.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
          // Imagem do prato com movimento dinâmico
          Center(
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  dragDistance += details.delta.dx; // Atualiza a distância percorrida
                });
              },
              onPanEnd: (_) {
                // Verifica se o swipe foi suficientemente longo
                if (dragDistance > screenWidth * 0.5) {
                  // Swipe para direita (aceitar/abrir detalhes)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetailsPage(
                        foodImage: foodImages[currentFoodIndex],
                        foodName: foodNames[currentFoodIndex],
                      ),
                    ),
                  );
                } else if (dragDistance < -screenWidth * 0.5) {
                  // Swipe para esquerda (rejeitar/próximo prato)
                  _changeFoodImage(1);
                }
                // Reseta a distância após o gesto
                setState(() {
                  dragDistance = 0;
                });
              },
              child: Transform.translate(
                offset: Offset(dragDistance, 0), // Movimenta a imagem
                child: Container(
                  width: 262,
                  height: 262,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(foodImages[currentFoodIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Botão de voltar
          Positioned(
            top: 336,
            left: 20,
            child: GestureDetector(
              onTap: () {
                _changeFoodImage(-1); // Swipe manual para esquerda
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
          // Botão de avançar
          Positioned(
            top: 336,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailsPage(
                      foodImage: foodImages[currentFoodIndex],
                      foodName: foodNames[currentFoodIndex],
                    ),
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
          // Ícone do usuário
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
          // Botões inferiores
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
