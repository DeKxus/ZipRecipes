import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zip_recipes_app/firebase/services/ingredient.dart';

class UserApp {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final Timestamp dateOfBirth;
  final int weight;
  final int height;
  // Calories
  final int objectiveCalories;
  final int currentCalories;
  // Favorite Recipes
  final List<String> favoriteRecipes;
  // Ingredients owned
  final List<Ingredient> ingredients;

  UserApp({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.weight,
    required this.height,
    required this.objectiveCalories,
    required this.currentCalories,
    required this.favoriteRecipes,
    required this.ingredients,
  });
}
