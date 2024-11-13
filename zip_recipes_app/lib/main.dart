import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zip_recipes_app/auth/regist.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistPage(),
    );
  }
}