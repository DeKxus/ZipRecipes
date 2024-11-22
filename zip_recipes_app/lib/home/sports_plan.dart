import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:zip_recipes_app/firebase/services/user_service.dart';
import '../widgets/num_field.dart';
import '../widgets/date_field.dart'; // Assuming you have this widget
import 'navigation.dart';


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
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  Future<void> _setPersonalInfo() async {
    final UserService userService = UserService();

    try {
      // Convert the Date of Birth string to a DateTime object
      DateTime? dob = DateFormat('dd-MM-yyyy').parse(dobController.text.trim());

      // Update user information with a Timestamp for the Date of Birth
      userService.updateUserSpecificDetails(
        weightController.text.trim(),
        heightController.text.trim(),
        Timestamp.fromDate(dob),  // Pass the DateTime object here
        caloriesController.text.trim(),
      );
    } catch (e) {
      print('Error updating user info: $e');
    }
  }


  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    caloriesController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _navigateToNextScreen() {
    final height = heightController.text.trim();
    final weight = weightController.text.trim();
    final calories = caloriesController.text.trim();
    final dob = dobController.text.trim();

    if (height.isEmpty || weight.isEmpty || calories.isEmpty || dob.isEmpty) {
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
      // Update the user's information
      _setPersonalInfo();

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
              CustomDateField(
                label: 'Date of Birth:',
                controller: dobController,
                onTap: () => _selectDate(context),
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
