import 'package:flutter/material.dart';
import 'package:zip_recipes_app/widgets/custom_settings_element.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black
                ),
              ),
            ),
          ),

          SizedBox(height: 16),

          // Personal information element
          CustomSettingsElement(imagePath: 'assets/images/icons/user_black.png', labelText: 'Personal Info'),

          SizedBox(height: 16),

          //Logout
          CustomSettingsElement(imagePath: 'assets/images/icons/user_black.png', labelText: 'Logout'),
          
        ],
      ),
    );
  }
}