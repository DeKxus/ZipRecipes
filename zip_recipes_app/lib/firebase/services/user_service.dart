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
            firstName: data['firstName'] ?? '',
            lastName: data['lastName'] ?? '',
            email: data['email'] ?? user.email!,
            dateOfBirth: data['dateOfBirth'] ?? Timestamp(0, 0),
            weight: data['weight'] ?? 0,
            height: data['height'] ?? 0,
            objectiveCalories: data['objectiveCalories'] ?? 0,
            currentCalories: data['currentCalories'] ?? 0,
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

  // Update user details (firstName and lastName)
  Future<void> updateUserDetails(String uid, String firstName, String lastName) async {
    try {
      await _usersCollection.doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
      });
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  // Update user calories (objective and current)
  Future<void> updateUserCalories(String uid, int objectiveCalories, int currentCalories) async {
    try {
      await _usersCollection.doc(uid).update({
        'objectiveCalories': objectiveCalories,
        'currentCalories': currentCalories,
      });
    } catch (e) {
      print('Error updating user calories: $e');
    }
  }

  // Update user ingredients
  Future<void> updateUserIngredients(String uid, List<Ingredient> ingredients) async {
    try {
      await _usersCollection.doc(uid).update({
        'ingredients': ingredients.map((ingredient) => {
              'id': ingredient.id,
              'name': ingredient.name,
              'type': ingredient.type,
            }).toList(),
      });
    } catch (e) {
      print('Error updating user ingredients: $e');
    }
  }
}
