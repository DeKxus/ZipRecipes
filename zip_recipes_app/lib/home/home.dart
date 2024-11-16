import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart'; // Importa o FirebaseAuth
import 'package:zip_recipes_app/home/scan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "User"; // Nome padrão caso não haja autenticação

  @override
  void initState() {
    super.initState();
    _fetchUserName(); // Obtém o nome do utilizador ao inicializar
  }

  // Método para buscar o nome do utilizador autenticado
  void _fetchUserName() {
    final User? user = FirebaseAuth.instance.currentUser; // Obtém o utilizador atual
    setState(() {
      if (user != null) {
        userName = user.displayName ?? user.email ?? "User"; // Nome, Email ou "User" como fallback
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
          // Circular background behind the food image, centered
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
          // Food image, centered
          Center(
            child: Container(
              width: 262,
              height: 262,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icons/food.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Left arrow, aligned to the left of the food image
          Positioned(
            top: 336,
            left: 20,
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
          // Right arrow, aligned to the right of the food image
          Positioned(
            top: 336,
            right: 20,
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
          // Profile image and username
          Positioned(
            top: 66,
            left: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 44,
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
          // Substituir pelo nome do utilizador autenticado
          Positioned(
            top: 83,
            left: 120,
            child: Text(
              userName, // Nome do utilizador
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
          // Calorie bar background
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
          // Calorie bar progress
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
            top: 92,
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
          // Bottom icons with circular background and click functionality
          Positioned(
            bottom: 80,
            left: 60,
            child: GestureDetector(
              onTap: () {
                print("Scan icon clicked");
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
                print("Groceries icon clicked");
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
