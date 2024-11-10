import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final EdgeInsetsGeometry horizontalPadding;
  final String focusedIconPath;  // Path to the image when focused
  final String unfocusedIconPath;  // Path to the image when unfocused

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.focusedIconPath,
    required this.unfocusedIconPath,
    this.obscureText = false,
    this.horizontalPadding = const EdgeInsets.symmetric(horizontal: 25.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding,
      child: Focus(
        onFocusChange: (hasFocus) {
          (context as Element).markNeedsBuild();
        },
        child: Builder(
          builder: (BuildContext context) {
            final isFocused = Focus.of(context).hasFocus;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                boxShadow: [
                  if (isFocused)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 4), // Controls the shadow position
                    ),
                ],
              ),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isFocused ? Colors.white : Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none, // Removes solid border
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none, // Removes solid border
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isFocused ? Colors.blue : Colors.grey, // Change color here
                  ),
                  prefixIcon: isFocused 
                      ? Image.asset(focusedIconPath, width: 5.0, height: 5.0) 
                      : Image.asset(unfocusedIconPath, width: 2.0, height: 30.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}