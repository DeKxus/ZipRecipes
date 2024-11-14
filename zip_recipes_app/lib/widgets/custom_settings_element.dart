import 'package:flutter/material.dart';

class CustomSettingsElement extends StatelessWidget {
  final String imagePath;
  final String labelText;
  final double? imageWidth;
  final double? imageHeight;

  const CustomSettingsElement({
    super.key,
    required this.imagePath,
    required this.labelText,
    this.imageWidth, // optional image width
    this.imageHeight, // optional image height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          // Round Container on the left
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: imageWidth ?? 50.0,
                height: imageHeight ?? 50.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Container holding the label text
          Expanded(
            child: SizedBox(
              height: 90,
              child: Center(
                child: Text(
                  labelText,
                  style: const TextStyle(
                    color: Color(0xFF8E8E8E),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
