import 'package:flutter/material.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/firebase/services/recipe_service.dart';
import 'package:zip_recipes_app/firebase/services/user_service.dart';
import 'package:zip_recipes_app/home/recipe_page.dart';
import 'package:zip_recipes_app/widgets/custom_favorite_element.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  List<Recipe> recipes = [];
  bool isLoading = true; 

  List<Recipe> _filteredRecipes = [];
  final TextEditingController _searchController = TextEditingController();

  void _fetchFavoriteRecipes() async {
    final UserService userService = UserService();
    final RecipeService recipeService = RecipeService();

     setState(() {
      isLoading = true; // Start loading
    });

    try {
      final favoriteRecipes = await userService.getFavoriteRecipes();
      print('Found ${favoriteRecipes.length} favorite recipes.');

      if (favoriteRecipes.length != 0) {
        recipes = await recipeService.getRecipesByIds(favoriteRecipes);
        print('Found ${recipes.length} favorite recipes.');
      } 

    } catch (e) {
      print('Error fetching recipes: $e');
    } finally {
      setState(() {
        _filteredRecipes = recipes;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFavoriteRecipes();
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
      _filteredRecipes = recipes
          .where((recipe) => recipe.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: isLoading
      ? const Center(
        child: CircularProgressIndicator(), // Show loading spinner
      )
      :Column(
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
                        builder: (context) => RecipePage(
                          recipe: recipe,
                        ),
                      ),
                    );
                  },
                  child: CustomFavoriteElement(
                    imagePath: recipe.image,
                    recipeName: recipe.name,
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
