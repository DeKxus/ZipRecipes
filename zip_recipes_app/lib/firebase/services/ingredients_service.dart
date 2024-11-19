import 'package:cloud_firestore/cloud_firestore.dart';
import 'ingredient.dart';

class IngredientService {
  final _ingredientsCollection = FirebaseFirestore.instance.collection('ingredients');

  // Fetch an ingredient by ID
  Future<Ingredient?> getIngredientById(String id) async {
    try {
      final doc = await _ingredientsCollection.doc(id).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return Ingredient(
          id: doc.id,
          name: data['name'] ?? '',
          type: data['type'] ?? '',
        );
      }
    } catch (e) {
      print('Error fetching ingredient by ID: $e');
    }
    return null;
  }

  // Fetch multiple ingredients by IDs
  Future<List<Ingredient>> getIngredientsByIds(List<String> ids) async {
    try {
      final snapshot = await _ingredientsCollection.where(FieldPath.documentId, whereIn: ids).get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Ingredient(
          id: doc.id,
          name: data['name'] ?? '',
          type: data['type'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error fetching ingredients by IDs: $e');
      return [];
    }
  }
}