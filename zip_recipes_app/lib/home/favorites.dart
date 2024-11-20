import 'package:flutter/material.dart';
import 'package:zip_recipes_app/widgets/custom_favorite_element.dart';
import 'FoodDetails.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<Map<String, String>> _allRecipes = List.generate(10, (index) {
    return {
      "name": "Tuna Salad $index",
      "imagePath": 'assets/images/icons/food.png',
    };
  });
  List<Map<String, String>> _filteredRecipes = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredRecipes = _allRecipes;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredRecipes = _allRecipes
          .where((recipe) => recipe["name"]!
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Page Title
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, top: 50.0),
              child: Text(
                'Favorite Recipes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search favorite recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),

          // Spacer and list of favorite items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = _filteredRecipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailsPage(
                          foodImage: recipe["imagePath"]!,
                          foodName: recipe["name"]!,
                        ),
                      ),
                    );
                  },
                  child: CustomFavoriteElement(
                    imagePath: recipe["imagePath"]!,
                    recipeName: recipe["name"]!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
