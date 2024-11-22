import 'package:flutter/material.dart';

class InsertList extends StatefulWidget {
  final List<Map<String, String>> initialTags;

  const InsertList({super.key, this.initialTags = const []});

  @override
  State<InsertList> createState() => _InsertListPageState();
}

class _InsertListPageState extends State<InsertList> {
  late List<Map<String, String>> tags;

  final List<String> foodItems = [
    'Beef',
    'Chicken',
    'Fish',
    'Rice',
    'Pasta',
    'Tomato',
    'Carrot',
    'Potato',
    'Broccoli',
    'Cheese',
    'Eggs',
    'Bread',
    'Milk',
    'Butter',
    'Yogurt'
  ];

  List<String> filteredFoodItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tags = List.from(widget.initialTags);
    filteredFoodItems = List.from(foodItems);
  }

  void _updateSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFoodItems = List.from(foodItems);
      } else {
        filteredFoodItems = foodItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _removeTag(int index) {
    setState(() {
      tags.removeAt(index);
    });
  }

  Future<void> _showAddQuantityDialog(String ingredient) async {
    String quantity = '';
    String unit = 'grams';
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
                      backgroundColor: Colors.red.shade100,
                      child: const Icon(Icons.restaurant_menu, color: Colors.red),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      ingredient,
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
                  items: ['grams', 'kg', 'liters', 'ml', 'units']
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
                            tags.add({'name': ingredient, 'quantity': '$quantity $unit'});
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
    if (tags.isEmpty) {
      _showFeedbackPopup(context, 'You need to add at least one ingredient before saving.');
    } else {
      _showFeedbackPopup(context, 'Ingredients have been successfully gathered!');
      Navigator.pop(context, tags);
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
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: const Alignment(0, -0.6), // Center horizontally and adjust vertically
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    height: 230, // Height constraint for the scrollable tags
                    width: MediaQuery.of(context).size.width * 0.8, // Width for centering
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: List.generate(tags.length, (index) {
                          final tag = tags[index];
                          return Chip(
                            label: Text('${tag['name']} - ${tag['quantity']}'),
                            backgroundColor:
                            index.isEven ? Colors.green.shade100 : Colors.red.shade100,
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
                    children: [
                      // Other non-scrollable content can go here
                    ],
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
                        height: 200, // Set height for the ingredients list
                        child: ListView.builder(
                          itemCount: filteredFoodItems.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.restaurant_menu, color: Colors.red),
                              title: Text(filteredFoodItems[index]),
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
