import 'package:flutter/material.dart';
import 'package:zip_recipes_app/home/navigation.dart';
import '../widgets/num_field.dart';

class PlanInputScreen extends StatefulWidget {
  final String planTitle;
  final IconData planIcon;
  final Color iconColor;

  const PlanInputScreen({
    super.key,
    required this.planTitle,
    required this.planIcon,
    required this.iconColor,
  });

  @override
  State<PlanInputScreen> createState() => _PlanInputScreenState();
}

class _PlanInputScreenState extends State<PlanInputScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    final age = ageController.text.trim();
    final height = heightController.text.trim();
    final weight = weightController.text.trim();
    final calories = caloriesController.text.trim();

    if (age.isEmpty || height.isEmpty || weight.isEmpty || calories.isEmpty) {
      // Show a dialog if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Missing Inputs'),
          content: const Text('Please fill in all the fields to proceed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // All inputs are valid, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: widget.iconColor.withOpacity(0.2),
                    radius: 28,
                    child: Icon(
                      widget.planIcon,
                      color: widget.iconColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${widget.planTitle} Plan',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CustomNumberField(
                label: 'Age',
                controller: ageController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomNumberField(
                      label: 'Height (cm)',
                      controller: heightController,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomNumberField(
                      label: 'Weight (kg)',
                      controller: weightController,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              CustomNumberField(
                label: 'Calories',
                controller: caloriesController,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _navigateToNextScreen,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Full-width button
                  backgroundColor: const Color(0xFF86D293), // Button color
                  foregroundColor: Colors.white, // Text color
                ),
                child: const Text('Next'),
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Don\'t worry, you can change this at any time!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
