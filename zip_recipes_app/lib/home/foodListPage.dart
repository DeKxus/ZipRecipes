import 'package:flutter/material.dart';

class Ingredient {
  final String id;
  final String name;
  final String type;

  Ingredient({
    required this.id,
    required this.name,
    required this.type,
  });
}

class FoodListPage extends StatefulWidget {
  final String foodType;

  const FoodListPage({super.key, required this.foodType});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final List<Ingredient> ingredients = [
    Ingredient(id: '1', name: 'Chicken', type: 'Proteins'),
    Ingredient(id: '2', name: 'Beef', type: 'Proteins'),
    Ingredient(id: '3', name: 'Fish', type: 'Proteins'),
    Ingredient(id: '4', name: 'Milk', type: 'Dairy'),
    Ingredient(id: '5', name: 'Cheese', type: 'Dairy'),
    Ingredient(id: '6', name: 'Carrot', type: 'Vegetables'),
    Ingredient(id: '7', name: 'Broccoli', type: 'Vegetables'),
    Ingredient(id: '8', name: 'Rice', type: 'Grains'),
    Ingredient(id: '9', name: 'Pasta', type: 'Grains'),
  ];

  late List<Ingredient> filteredIngredients;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Filter ingredients based on the initial food type
    filteredIngredients = ingredients
        .where((ingredient) => ingredient.type == widget.foodType)
        .toList();

    // Listen for search bar text changes
    _searchController.addListener(() {
      _filterIngredients(_searchController.text);
    });
  }

  void _filterIngredients(String query) {
    setState(() {
      if (query.isEmpty) {
        // Show all ingredients of the selected type if query is empty
        filteredIngredients = ingredients
            .where((ingredient) => ingredient.type == widget.foodType)
            .toList();
      } else {
        // Filter by name and type
        filteredIngredients = ingredients
            .where((ingredient) =>
        ingredient.type == widget.foodType &&
            ingredient.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Same background color as InsertList
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.foodType,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search ingredients...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          // List of Ingredients
          Expanded(
            child: ListView.builder(
              itemCount: filteredIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = filteredIngredients[index];

                // Determine the CircleAvatar color based on the ingredient type
                Color getCircleAvatarColor(String type) {
                  switch (type) {
                    case 'Proteins':
                      return Colors.red.shade100;
                    case 'Others':
                      return Colors.purple.shade100;
                    case 'Dairy':
                      return const Color.fromRGBO(209, 232, 247, 1);
                    case 'Grains':
                      return Colors.yellow.shade100;
                    case 'Vegetables':
                      return Colors.green.shade100;
                    default:
                      return Colors.grey.shade300;
                  }
                }

                Color getIconColor(String type) {
                  switch (type) {
                    case 'Proteins':
                      return Colors.red;
                    case 'Others':
                      return Colors.purple;
                    case 'Dairy':
                      return Colors.blue;
                    case 'Grains':
                      return Colors.orange;
                    case 'Vegetables':
                      return Colors.green.shade700;
                    default:
                      return Colors.grey;
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: getCircleAvatarColor(ingredient.type),
                        child: Icon(
                          Icons.restaurant_menu,
                          color: getIconColor(ingredient.type),
                        ),
                      ),
                      title: Text(
                        ingredient.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Type: ${ingredient.type}'),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
