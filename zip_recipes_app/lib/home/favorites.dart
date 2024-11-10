import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zip_recipes_app/widgets/custom_favorite_element.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Page Title
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top:50.0),
              child: Text(
                'Favorite Recipes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black
                ),
              ),
            ),
          ),

          SizedBox(height: 16),

          //Scroll List with items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder: (context, index) {
                return CustomFavoriteElement(imagePath: 'assets/images/icons/food.png', recipeName: 'Tuna Salad');
              },
            ),
          ),

        ],
      )
    );
  }
}


