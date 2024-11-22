import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zip_recipes_app/firebase/services/ingredient.dart';

import 'InsertList.dart'; // Importa o arquivo InsertList.dart

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final ImagePicker _picker = ImagePicker(); // Instância do ImagePicker

  // Lista pré-definida para o botão "Scan Text"
  final List<IngredientWithQuantity> predefinedIngredients = [
    IngredientWithQuantity(id:'i1',type: 'Grains', name: 'rice', quantity: '500g'),
    IngredientWithQuantity(id:'i2',type: 'Vegetables', name: 'onion', quantity: '500g'),
    IngredientWithQuantity(id:'i3',type: 'Proteins', name: 'salmon', quantity: '500g'),
    IngredientWithQuantity(id:'i4',type: 'Others', name: 'Salt', quantity: '1kg'),
    IngredientWithQuantity(id:'i5', type: 'Others', name: 'pepper', quantity: '25g'),
  ];

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Após capturar a imagem, navegue para a página InsertList com a lista predefinida
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InsertList(ingredientsToAdd: predefinedIngredients),
        ),
      );
    }
  }

  // Método para abrir a página InsertList ao clicar em "Insert List"
  void _openInsertList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InsertList(ingredientsToAdd: []), // Lista inicial vazia
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
        title: const Text(
          'Scan Ingredients', // Adicionando o título
          style: TextStyle(
            color: Colors.black, // Cor do texto
            fontSize: 24.0, // Tamanho da fonte
            fontWeight: FontWeight.bold, // Negrito
          ),
        ),
        centerTitle: true, // Centraliza o título
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Scan text element
            GestureDetector(
              onTap: _openCamera,
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
