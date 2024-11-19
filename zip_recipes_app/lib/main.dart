import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zip_recipes_app/firebase/services/ingredient.dart';
import 'package:zip_recipes_app/firebase/services/user_service.dart';
import 'auth/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  //testing
  UserService userService = UserService();

  List<Ingredient> newIngredients = [
    Ingredient(id: 'riceId', name: 'Rice', type: 'Grain'),
    Ingredient(id: 'appleId', name: 'Apple', type: 'Fruit'),
  ];

  await userService.updateUserIngredients('4tF3oImyYTNZ0IgYDOM4J34o19Y2', newIngredients);
  print('User ingredients updated successfully.');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}