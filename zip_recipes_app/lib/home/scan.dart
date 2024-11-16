import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'InsertList.dart'; // Importa o arquivo InsertList.dart

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final ImagePicker _picker = ImagePicker(); // Instância do ImagePicker

  // Lista pré-definida para o botão "Scan Text"
  final List<Map<String, String>> predefinedTags = [
    {'name': 'lettuce', 'quantity': '500g'},
    {'name': 'onion', 'quantity': '500g'},
    {'name': 'salmon', 'quantity': '500g'},
    {'name': 'salt', 'quantity': '1kg'},
    {'name': 'pepper', 'quantity': '25g'}
  ];

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Após capturar a imagem, navegue para a página InsertList com a lista predefinida
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InsertList(initialTags: predefinedTags),
        ),
      );
    }
  }

  // Método para abrir a página InsertList ao clicar em "Insert List"
  void _openInsertList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InsertList(initialTags: []), // Lista inicial vazia
      ),
    );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Scan text element
            GestureDetector(
              onTap: _openCamera, // Chama o método _openCamera ao pressionar
              child: Container(
                width: 150.0,
                height: 150.0,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/icons/scan_text.png',
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        'Scan text',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8E8E8E),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Insert list element
            GestureDetector(
              onTap: _openInsertList, // Chama o método _openInsertList ao pressionar
              child: Container(
                width: 150.0,
                height: 150.0,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/icons/pencil.png',
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        'Insert list',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8E8E8E),
                        ),
                      ),
                    ],
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
