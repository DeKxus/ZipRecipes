import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap; // Add onTap callback

  const CustomDateField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            readOnly: true, // Make the field read-only to prevent manual typing
            decoration: InputDecoration(
              hintText: 'Select Date',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onTap: onTap, // Trigger onTap when the field is tapped
          ),
        ],
      ),
    );
  }
}
