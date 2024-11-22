import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:zip_recipes_app/firebase/services/ingredient.dart';
import 'package:zip_recipes_app/firebase/services/user.dart';

class UserService {
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Get the current logged-in user
  Future<UserApp?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final document = await _usersCollection.doc(user.uid).get();
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;

          // Create UserApp from Firestore data
          return UserApp(
            id: document.id,
            firstName: data['first name'] ?? '',
            lastName: data['last name'] ?? '',
            email: data['email'] ?? user.email!,
            dateOfBirth: data['date of birth'] ?? Timestamp(0, 0),
            weight: data['weight'] ?? 0,
            height: data['height'] ?? 0,
            objectiveCalories: data['objective calories'] ?? 0,
            currentCalories: data['current calories'] ?? 0,
            favoriteRecipes: (data['favorite recipes'] as List<dynamic>?)
                  ?.map((item) => item.toString())
                  .toList() ??
              [],
            ingredients: (data['ingredients'] as List<dynamic>?)
                    ?.map((item) => Ingredient(
                          id: item['id'] ?? '',
                          name: item['name'] ?? '',
                          type: item['type'] ?? '',
                        ))
                    .toList() ??
                [],
          );
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
    return null;
  }
   // Update user details (weight, height, dob, objectiveCalories)
  Future<void> updateUserSpecificDetails(
    String weight,
    String height,
    Timestamp dob,
    String objectiveCalories,
  ) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'weight': weight,
          'heigth': height,
          'date of birth': dob,
          'objective calories': objectiveCalories,
        });
        print("User details updated successfully!");
      } else {
        print("No user is currently logged in.");
      }
    } catch (e) {
      print('Error updating user details: $e');
    }
  }


  // Update user details (firstName and lastName)
  Future<void> updateUserDetails(String firstName, String lastName) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).update({
          'first name': firstName,
          'last name': lastName,
        });
      }
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  Future<Map<String, String?>> getUserDetails() async {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      // Fetch the user document from Firestore
      final userDoc = await _usersCollection.doc(user.uid).get();
      
      // Check if the document exists
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        // Return the first and last name from the user document
        return {
          'first name': data['first name'] as String?,
          'last name': data['last name'] as String?,
        };
      } else {
        print('User document does not exist.');
        return {};
      }
    } else {
      print('No user is currently logged in.');
      return {};
    }
  } catch (e) {
    print('Error fetching user details: $e');
    return {};
  }
}

  // Update user calories (objective and current)
  Future<void> updateUserCalories(int objectiveCalories, int currentCalories) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).update({
          'objective calories': objectiveCalories,
          'current calories': currentCalories,
        });
      }
    } catch (e) {
      print('Error updating user calories: $e');
    }
  }

  // Update user ingredients
  Future<void> updateUserIngredients(List<Ingredient> ingredients) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).update({
          'ingredients': ingredients.map((ingredient) => {
                'id': ingredient.id,
                'name': ingredient.name,
                'type': ingredient.type,
              }).toList(),
        });
      }
    } catch (e) {
      print('Error updating user ingredients: $e');
    }
  }

  // Get the ingredients of the current logged-in user
  Future<List<Ingredient>> getUserIngredients() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final document = await _usersCollection.doc(user.uid).get();
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;
          final ingredients = (data['ingredients'] as List<dynamic>?)
                  ?.map((item) => Ingredient(
                        id: item['id'] ?? '',
                        name: item['name'] ?? '',
                        type: item['type'] ?? '',
                      ))
                  .toList() ??
              [];
          return ingredients;
        }
      }
    } catch (e) {
      print('Error fetching user ingredients: $e');
    }
    return [];
  }

  /// Add a recipe to the user's favorite recipes list
  Future<void> addFavoriteRecipe(String recipeId) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).update({
          'favorite recipes': FieldValue.arrayUnion([recipeId]),
        });
        print('Recipe $recipeId added to favorites.');
      }
    } catch (e) {
      print('Error adding favorite recipe: $e');
    }
  }

  /// Get the list of favorite recipe IDs for the current user
  Future<List<String>> getFavoriteRecipes() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final document = await _usersCollection.doc(user.uid).get();
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;
          final favoriteRecipes = (data['favorite recipes'] as List<dynamic>?)
                  ?.map((item) => item.toString())
                  .toList() ??
              [];
          return favoriteRecipes;
        }
      }
    } catch (e) {
      print('Error fetching favorite recipes: $e');
    }
    return [];
  }
}
