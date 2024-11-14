import 'package:flutter/material.dart';
import 'package:zip_recipes_app/auth/login.dart';
import 'package:zip_recipes_app/widgets/custom_settings_element.dart';

import 'personal_info.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
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
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Personal information element with navigation
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInfoPage()));
            },
            child: const CustomSettingsElement(
              imagePath: 'assets/images/icons/user_black.png',
              labelText: 'Personal Info',
            ),
          ),
          const SizedBox(height: 16),

          // Logout element with confirmation dialog
          GestureDetector(
            onTap: _showLogoutConfirmationDialog,
            child: const CustomSettingsElement(
              imagePath: 'assets/images/icons/logout.png',
              labelText: 'Logout',
            ),
          ),
        ],
      ),
    );
  }
}

