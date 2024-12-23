import 'package:flutter/material.dart';
import 'package:zip_recipes_app/firebase/services/ingredient.dart';
import 'package:zip_recipes_app/firebase/services/ingredients_service.dart';
import 'package:zip_recipes_app/firebase/services/user_service.dart';

class InsertList extends StatefulWidget {
  final List<IngredientWithQuantity> ingredientsToAdd;

  const InsertList({super.key, this.ingredientsToAdd = const []});

  @override
  State<InsertList> createState() => _InsertListPageState();
}

class _InsertListPageState extends State<InsertList> {
  late List<IngredientWithQuantity> selectedFoodItems = [];

  List<Ingredient> foodItems = [];
  List<Ingredient> filteredFoodItems = [];
  final TextEditingController _searchController = TextEditingController();

  bool isLoading = true; // Track loading state

  Color _getBackgroundColor(String type) {
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

  Color _getDarkerColor(Color color) {
    return HSLColor.fromColor(color).withLightness((HSLColor.fromColor(color).lightness - 0.2).clamp(0, 1)).toColor();
  }

  void _fetchIngredients() async {
    final IngredientService ingredientService = IngredientService();

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      foodItems = await ingredientService.getAllIngredients();
      print('Found ${foodItems.length} ingredients.');
    } catch (e) {
      print('Error fetching recipes: $e');
    } finally {
      setState(() {
        filteredFoodItems = List.from(foodItems);
        isLoading = false; // Stop loading after fetching
      });
    }
  }

  void _updateUserIngredients() async {
    final UserService userService = UserService();

    try {
      await userService.updateUserIngredients(selectedFoodItems);
      print('Updated user with ${selectedFoodItems.length} ingredients.');
    } catch (e) {
      print('Error updating ingredients: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchIngredients();
    selectedFoodItems = List.from(widget.ingredientsToAdd);
  }

  void _updateSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFoodItems = List.from(foodItems);
      } else {
        filteredFoodItems = foodItems
            .where((ingredient) => ingredient.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _removeTag(int index) {
    setState(() {
      selectedFoodItems.removeAt(index);
    });
  }

  Future<void> _showAddQuantityDialog(Ingredient ingredient) async {
    String quantity = '';
    String unit = 'g';
    const greenColor = Color(0xFF86D293);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getBackgroundColor(ingredient.type),
                      child: Icon(Icons.restaurant_menu, color: _getDarkerColor(_getBackgroundColor(ingredient.type))),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      ingredient.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Insert quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    quantity = value;
                  },
                ),
                const SizedBox(height: 24.0),
                DropdownButtonFormField<String>(
                  value: unit,
                  items: ['g', 'kg', 'liters', 'ml', 'units']
                      .map((String value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ))
                      .toList(),
                  onChanged: (value) {
                    unit = value ?? 'grams';
                  },
                  decoration: InputDecoration(
                    labelText: 'Unit',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greenColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (quantity.isNotEmpty) {
                          setState(() {
                            selectedFoodItems.add(IngredientWithQuantity(
                              id: ingredient.id,
                              name: ingredient.name,
                              type: ingredient.type,
                              quantity: '$quantity $unit',
                            ));
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFeedbackPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onSavePressed() {
    if (selectedFoodItems.isEmpty) {
      _showFeedbackPopup(context, 'You need to add at least one ingredient before saving.');
    } else {
      _showFeedbackPopup(context, 'Ingredients have been successfully gathered!');
      _updateUserIngredients();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: const Alignment(0, -0.6),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: List.generate(selectedFoodItems.length, (index) {
                          final tag = selectedFoodItems[index];
                          return Chip(
                            label: Text('${tag.name} - ${tag.quantity}'),
                            backgroundColor: _getBackgroundColor(tag.type),
                            deleteIcon: Icon(Icons.close, color: Colors.grey.shade600),
                            onDeleted: () => _removeTag(index),
                          );
                        }),
                      ),
                    ),

                  ),
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                              ),
                              onChanged: _updateSearch,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: filteredFoodItems.length,
                          itemBuilder: (context, index) {
                            final backgroundColor = _getBackgroundColor(filteredFoodItems[index].type);
                            final darkerColor = _getDarkerColor(backgroundColor);
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: backgroundColor,
                                child: Icon(Icons.restaurant_menu, color: darkerColor),
                              ),
                              title: Text(filteredFoodItems[index].name),
                              onTap: () => _showAddQuantityDialog(filteredFoodItems[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF86D293),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _onSavePressed,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
