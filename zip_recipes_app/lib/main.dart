import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zip_recipes_app/firebase/services/ingredient.dart';
import 'package:zip_recipes_app/firebase/services/ingredients_service.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/firebase/services/recipe_service.dart';
import 'auth/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  //addSampleData();

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




void addSampleData() async {
  final ingredientService = IngredientService();
  final recipeService = RecipeService();

  // Add some ingredients
  final riceId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Rice', type: 'Grains'));
  final codId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Cod', type: 'Proteins'));
  final mushroomId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Mushroom', type: 'Vegetables'));
  final chickenId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Chicken', type: 'Proteins'));
  final salmonId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Salmon', type: 'Proteins'));
  final cheeseId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Cheese', type: 'Dairy'));
  final lettuceId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Lettuce', type: 'Vegetables'));
  final tomatoId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Tomato', type: 'Vegetables'));
  final carrotId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Carrot', type: 'Vegetables'));
  final cucumberId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Cucumber', type: 'Vegetables'));
  final oliveOilId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Olive Oil', type: 'Others'));
  final garlicId = await ingredientService.addIngredient(Ingredient(id: '', name: 'Garlic', type: 'Others'));

  if (riceId != null &&
      codId != null &&
      mushroomId != null &&
      chickenId != null &&
      salmonId != null &&
      cheeseId != null &&
      lettuceId != null &&
      tomatoId != null &&
      carrotId != null &&
      cucumberId != null &&
      oliveOilId != null &&
      garlicId != null) {
    // Add the first recipe: Vegetable Cod
    final vegetableCodId = await recipeService.addRecipe(Recipe(
      id: '',
      name: 'Vegetable Cod',
      image: 'assets/images/food_images/BacalhauVegetais.png',
      salt: '2.5g',
      fat: '6g',
      energy: '250kcal',
      protein: '30g',
      ingredients: [
        Ingredient(id: codId, name: 'Cod', type: 'Proteins'),
        Ingredient(id: mushroomId, name: 'Mushroom', type: 'Vegetables'),
        Ingredient(id: lettuceId, name: 'Lettuce', type: 'Vegetables'),
        Ingredient(id: garlicId, name: 'Garlic', type: 'Others'),
        Ingredient(id: oliveOilId, name: 'Olive Oil', type: 'Others'),
      ],
      information: 'A light and healthy cod dish with fresh vegetables.',
      guide: [
        RecipeStep(description: 'Season cod with salt, garlic, and olive oil.'),
        RecipeStep(description: 'Steam cod and mushrooms together.', timer: 15),
        RecipeStep(description: 'Serve cod on a bed of fresh lettuce.'),
      ],
    ));
    print('Vegetable Cod Recipe added with ID: $vegetableCodId');

    // Add the second recipe: Chicken Salad
    final chickenSaladId = await recipeService.addRecipe(Recipe(
      id: '',
      name: 'Chicken Salad',
      image: 'assets/images/food_images/ChickenSalad.png',
      salt: '3g',
      fat: '8g',
      energy: '280kcal',
      protein: '35g',
      ingredients: [
        Ingredient(id: chickenId, name: 'Chicken', type: 'Proteins'),
        Ingredient(id: lettuceId, name: 'Lettuce', type: 'Vegetables'),
        Ingredient(id: tomatoId, name: 'Tomato', type: 'Vegetables'),
        Ingredient(id: cucumberId, name: 'Cucumber', type: 'Vegetables'),
        Ingredient(id: oliveOilId, name: 'Olive Oil', type: 'Others'),
      ],
      information: 'A healthy and protein-packed chicken salad.',
      guide: [
        RecipeStep(description: 'Grill chicken until fully cooked.', timer: 15),
        RecipeStep(description: 'Chop lettuce, tomatoes, and cucumbers and mix in a bowl.'),
        RecipeStep(description: 'Add sliced grilled chicken and drizzle with olive oil.'),
      ],
    ));
    print('Chicken Salad Recipe added with ID: $chickenSaladId');

    // Add the third recipe: Mushroom and Vegetables
    final mushroomAndVegetablesId = await recipeService.addRecipe(Recipe(
      id: '',
      name: 'Mushroom and Vegetables',
      image: 'assets/images/food_images/CogumelosVegetais.png',
      salt: '1.8g',
      fat: '4g',
      energy: '150kcal',
      protein: '10g',
      ingredients: [
        Ingredient(id: mushroomId, name: 'Mushroom', type: 'Vegetables'),
        Ingredient(id: tomatoId, name: 'Tomato', type: 'Vegetables'),
        Ingredient(id: carrotId, name: 'Carrot', type: 'Vegetables'),
        Ingredient(id: garlicId, name: 'Garlic', type: 'Others'),
        Ingredient(id: oliveOilId, name: 'Olive Oil', type: 'Others'),
      ],
      information: 'A simple and delicious vegetable-based dish.',
      guide: [
        RecipeStep(description: 'Sauté mushrooms, tomatoes, and carrots in olive oil.', timer: 10),
        RecipeStep(description: 'Add minced garlic and season with salt.'),
        RecipeStep(description: 'Serve as a side or a light main dish.'),
      ],
    ));
    print('Mushroom and Vegetables Recipe added with ID: $mushroomAndVegetablesId');

    // Add the fourth recipe: Tuna Salad
    final tunaSaladId = await recipeService.addRecipe(Recipe(
      id: '',
      name: 'Tuna Salad',
      image: 'assets/images/food_images/SaladaAtum.png',
      salt: '2g',
      fat: '10g',
      energy: '330kcal',
      protein: '33g',
      ingredients: [
        Ingredient(id: lettuceId, name: 'Lettuce', type: 'Vegetables'),
        Ingredient(id: tomatoId, name: 'Tomato', type: 'Vegetables'),
        Ingredient(id: cucumberId, name: 'Cucumber', type: 'Vegetables'),
        Ingredient(id: salmonId, name: 'Salmon', type: 'Proteins'),
        Ingredient(id: oliveOilId, name: 'Olive Oil', type: 'Others'),
      ],
      information: 'A simple and healthy tuna salad recipe.',
      guide: [
        RecipeStep(description: 'Chop lettuce, tomatoes, and cucumbers and mix in a bowl.'),
        RecipeStep(description: 'Add chunks of salmon and drizzle with olive oil.'),
        RecipeStep(description: 'Mix well and serve chilled.'),
      ],
    ));
    print('Tuna Salad Recipe added with ID: $tunaSaladId');

    // Add the fifth recipe: Salmon Salad
    final salmonSaladId = await recipeService.addRecipe(Recipe(
      id: '',
      name: 'Salmon Salad',
      image: 'assets/images/food_images/SalmonSalad.png',
      salt: '2.2g',
      fat: '12g',
      energy: '320kcal',
      protein: '28g',
      ingredients: [
        Ingredient(id: salmonId, name: 'Salmon', type: 'Proteins'),
        Ingredient(id: lettuceId, name: 'Lettuce', type: 'Vegetables'),
        Ingredient(id: cheeseId, name: 'Cheese', type: 'Dairy'),
        Ingredient(id: carrotId, name: 'Carrot', type: 'Vegetables'),
        Ingredient(id: oliveOilId, name: 'Olive Oil', type: 'Others'),
      ],
      information: 'A creamy salmon salad with fresh greens.',
      guide: [
        RecipeStep(description: 'Grill salmon until fully cooked.', timer: 15),
        RecipeStep(description: 'Mix lettuce, shredded cheese, and grated carrot in a bowl.'),
        RecipeStep(description: 'Add grilled salmon chunks and drizzle with olive oil.'),
      ],
    ));
    print('Salmon Salad Recipe added with ID: $salmonSaladId');
  }
}