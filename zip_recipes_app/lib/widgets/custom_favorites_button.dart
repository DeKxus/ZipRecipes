import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteButton extends StatefulWidget {
  final String recipeId; // Recipe ID to be passed

  const FavoriteButton({Key? key, required this.recipeId}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  // Track button state
  bool isActive = false;
  bool isLoading = true; // Track if the initial state is being loaded

  // Image paths for active and inactive states
  final String activeImage = 'assets/images/icons/favorite_red.png'; // Replace with your active image asset
  final String inactiveImage = 'assets/images/icons/favorite_gray.png'; // Replace with your inactive image asset

  final _auth = FirebaseAuth.instance;
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _checkIfFavorite(); // Check the initial state
  }

  Future<void> _checkIfFavorite() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _usersCollection.doc(user.uid).get();
        final favorites = List<String>.from(doc['favorite recipes'] ?? []);
        setState(() {
          isActive = favorites.contains(widget.recipeId);
        });
      }
    } catch (e) {
      print('Error checking if recipe is favorite: $e');
    } finally {
      setState(() {
        isLoading = false; // Loading is complete
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while checking the initial state
      return const SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () {
        // Change state and perform the corresponding action
        setState(() {
          isActive = !isActive;
          if (isActive) {
            _addToFavorites();
          } else {
            _removeFromFavorites();
          }
        });
      },
      child: Image.asset(
        isActive ? activeImage : inactiveImage,
        width: 100, // Replace with desired width
        height: 100, // Replace with desired height
      ),
    );
  }

  Future<void> _addToFavorites() async {
    // Add the recipe to favorites
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).update({
          'favorite recipes': FieldValue.arrayUnion([widget.recipeId]),
        });
        print('Recipe ${widget.recipeId} added to favorites.');
      }
    } catch (e) {
      print('Error adding favorite recipe: $e');
    }
  }

  Future<void> _removeFromFavorites() async {
    // Remove the recipe from favorites
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _usersCollection.doc(user.uid).update({
          'favorite recipes': FieldValue.arrayRemove([widget.recipeId]),
        });
        print('Recipe ${widget.recipeId} removed from favorites.');
      }
    } catch (e) {
      print('Error removing favorite recipe: $e');
    }
  }
}