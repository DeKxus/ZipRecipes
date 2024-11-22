import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zip_recipes_app/firebase/services/ingredients_service.dart';
import 'recipe.dart';

class RecipeService {
  final _recipesCollection = FirebaseFirestore.instance.collection('recipes');
  final IngredientService _ingredientService = IngredientService();

  // Add a new recipe
  Future<String?> addRecipe(Recipe recipe) async {
    try {
      final ingredientIds = await Future.wait(recipe.ingredients.map((ingredient) async {
        if (ingredient.id.isEmpty) {
          final newId = await _ingredientService.addIngredient(ingredient);
          return newId ?? '';
        }
        return ingredient.id;
      }).toList());

      final docRef = await _recipesCollection.add({
        'name': recipe.name,
        'image': recipe.image,
        'salt': recipe.salt,
        'fat': recipe.fat,
        'energy': recipe.energy,
        'protein': recipe.protein,
        'ingredients': ingredientIds,
        'information': recipe.information,
        'guide': recipe.guide.map((step) => {
              'description': step.description,
              'timer': step.timer,
            }).toList(),
      });
      return docRef.id; // Return the ID of the newly added recipe
    } catch (e) {
      print('Error adding recipe: $e');
      return null;
    }
  }

  // Fetch all recipes
  Future<List<Recipe>> getAllRecipes() async {
    try {
      final snapshot = await _recipesCollection.get();
      return Future.wait(snapshot.docs.map((doc) => _mapDocumentToRecipe(doc)).toList());
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }

  // Get recipes that can be made with given ingredient IDs
  Future<List<Recipe>> getRecipesWithIngredients(List<String> availableIngredientIds) async {
    try {
      final allRecipes = await getAllRecipes();

      // Filter recipes where all required ingredient IDs are in the availableIngredientIds
      return allRecipes.where((recipe) {
        final recipeIngredientIds = recipe.ingredients.map((i) => i.id).toList();
        return recipeIngredientIds.every((id) => availableIngredientIds.contains(id));
      }).toList();
    } catch (e) {
      print('Error filtering recipes by ingredients: $e');
      return [];
    }
  }

  // Fetch a group of recipes by their IDs
  Future<List<Recipe>> getRecipesByIds(List<String> ids) async {
    try {
      final snapshot = await _recipesCollection.where(FieldPath.documentId, whereIn: ids).get();
      return Future.wait(snapshot.docs.map((doc) => _mapDocumentToRecipe(doc)).toList());
    } catch (e) {
      print('Error fetching recipes by IDs: $e');
      return [];
    }
  }

  // Helper function to map Firestore document to Recipe model
  Future<Recipe> _mapDocumentToRecipe(QueryDocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;

    // Fetch ingredient details using their IDs
    final ingredientIds = List<String>.from(data['ingredients'] ?? []);
    final ingredients = await _ingredientService.getIngredientsByIds(ingredientIds);

    // Map the 'guide' field to a List<Step>
    final guide = (data['guide'] as List<dynamic>? ?? []).map((stepData) {
      final stepMap = stepData as Map<String, dynamic>;
      return RecipeStep(
        description: stepMap['description'] ?? '',
        timer: stepMap['timer'] != null ? stepMap['timer'] as int : null,
      );
    }).toList();

    return Recipe(
      id: doc.id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      salt: data['salt'] ?? '',
      fat: data['fat'] ?? '',
      energy: data['energy'] ?? '',
      protein: data['protein'] ?? '',
      ingredients: ingredients,
      information: data['information'] ?? '',
      guide: guide,
    );
  }
}