import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
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

  String userName = "User"; // Nome do usuário
  final String profileImage = 'assets/images/icons/user_black.png'; // Caminho da imagem de perfil

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchUserInfo();
  }

  /// Obtém o nome do usuário autenticado
  void _fetchUserName() {
    final User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      if (user != null) {
        userName = user.email ?? user.displayName ?? "User";
      }
    });
  }

  /// Busca as informações do usuário no Firestore
  Future<void> _fetchUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users') // Coleção onde os dados estão armazenados
          .doc(user.uid) // Documento com ID do usuário
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data();
        setState(() {
          _firstNameController.text = data?['firstName'] ?? '';
          _lastNameController.text = data?['lastName'] ?? '';
          _dobController.text = data?['dob'] ?? '';
          _heightController.text = data?['height']?.toString() ?? '';
          _weightController.text = data?['weight']?.toString() ?? '';
          _caloriesController.text = data?['calories']?.toString() ?? '';
        });
      }
    } catch (e) {
      print('Erro ao buscar informações do usuário: $e');
    }
  }

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

  /// Salva as informações atualizadas no Firestore
  Future<void> _saveUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'dob': _dobController.text,
        'height': int.tryParse(_heightController.text) ?? 0,
        'weight': int.tryParse(_weightController.text) ?? 0,
        'calories': int.tryParse(_caloriesController.text) ?? 0,
      });

      // Exibe uma mensagem de sucesso
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
    } catch (e) {
      print('Erro ao salvar informações do usuário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          'Personal Info',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Adicionando a imagem circular no topo
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400, width: 2),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        child: Image.asset(
                          profileImage,
                          fit: BoxFit.contain,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Campos do formulário
            CustomTextField(
              label: "First Name",
              hint: "John",
              controller: _firstNameController,
            ),
            CustomTextField(
              label: "Last Name",
              hint: "Doe",
              controller: _lastNameController,
            ),
            CustomDateField(
              label: 'Date of Birth:',
              controller: _dobController,
              onTap: () => _selectDate(context),
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
                onPressed: _saveUserInfo,
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
