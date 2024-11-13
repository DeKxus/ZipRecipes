import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zip_recipes_app/home/navigation.dart';
import 'package:zip_recipes_app/widgets/custom_pill_button.dart';
import 'package:zip_recipes_app/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(); 
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

   Future signIn() async {
    try {
      //Authenticate user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim()
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationPage()),
      );
    } catch (e) {
      // Login failed, show error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Login Failed"),
            content: Text(e.toString()), 
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              // Logo image
              SizedBox(height: 25),
              // Primary title text
              Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black
                ),
              ),
              SizedBox(height: 25),

              // Secondary title text
              Text(
                'Please sign in to continue',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF8E8E8E)
                ),
              ),
              SizedBox(height: 25),
              
              //email textfield
              CustomTextField(
                controller: _emailController, 
                hintText: 'EMAIL', 
                focusedIconPath: 'assets/images/icons/email_black.png',
                unfocusedIconPath: 'assets/images/icons/email_grey.png'
                ),
              SizedBox(height: 16.0),
        
              //password textfield
              CustomTextField(
                controller: _passwordController, 
              hintText: 'PASSWORD', 
              obscureText: true,
              focusedIconPath: 'assets/images/icons/email_grey.png',
                unfocusedIconPath: 'assets/images/icons/email_black.png'
              ),
              SizedBox(height: 16.0),

              //sign in button
              CustomPillButton(
                text: 'SIGN UP',
                onPressed: () {
                  print("Button Pressed!");
                  signIn();
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}