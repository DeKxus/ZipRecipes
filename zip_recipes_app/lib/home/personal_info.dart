import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zip_recipes_app/widgets/date_field.dart';
import 'package:zip_recipes_app/widgets/num_field.dart';
import 'package:zip_recipes_app/widgets/text_field_personal_info.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _caloriesController.dispose();
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
        _dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Personal Info',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "First Name",
              hint: "John",
              controller: _firstNameController,
            ),
            CustomTextField(
              label: "Last Name",
              hint: "Dohn",
              controller: _lastNameController,
            ),
            CustomDateField(
              label: 'Date of Birth:',
              controller: _dobController,
              onTap: () => _selectDate(context), // Pass _selectDate as the onTap callback
            ),
            Row(
              children: [
                Expanded(
                  child: CustomNumberField(
                    label: 'Height (cm):',
                    controller: _heightController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomNumberField(
                    label: 'Weight (kg):',
                    controller: _weightController,
                  ),
                ),
              ],
            ),
            CustomNumberField(
              label: 'Calories:',
              controller: _caloriesController,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String firstName = _firstNameController.text;
                  String lastName = _lastNameController.text;
                  String dateOfBirth = _dobController.text;
                  String height = _heightController.text;
                  String weight = _weightController.text;
                  String calories = _caloriesController.text;

                  print('First Name: $firstName');
                  print('Last Name: $lastName');
                  print('Date of Birth: $dateOfBirth');
                  print('Height (cm): $height');
                  print('Weight (kg): $weight');
                  print('Calories: $calories');

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Update Confirmation'),
                        content: const Text('Personal information has been updated successfully!'),
                        actions: [
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF86D293),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'UPDATE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
