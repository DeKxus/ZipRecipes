import 'package:zip_recipes_app/firebase/services/ingredient.dart';

class Recipe{
  final String id;
  final String name;
  //Image
  final String image; //since we mighthave problems with storage the easiest way is simply to save a reference to the foto
  //Details
  final String salt;
  final String fat;
  final String energy;
  final String protein;
  //Ingredients
  final List<Ingredient> ingredients;
  //Short Recipe explanation
  final String information;
  //Step by step guide
  final List<RecipeStep> guide; //it can be a list of tuples (timer value if needed, text about the step)

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.salt,
    required this.fat,
    required this.energy,
    required this.protein,
    required this.ingredients,
    required this.information,
    required this.guide,
  });
}

class RecipeStep {
  final String description; // Text about the step
  final int? timer; // Optional timer in minutes (null if not needed)

  RecipeStep({
    required this.description,
    this.timer,
  });
}