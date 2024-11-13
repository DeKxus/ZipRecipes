import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zip_recipes_app/auth/regist.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              
              SizedBox(height: 100),

              // Logo image
              SizedBox(
                width: 160.0, // Set the desired width
                height: 130.0, // Set the desired height
                child: Image.asset(
                  'assets/images/logos/logo.png', // Path to your image asset
                  fit: BoxFit.contain, // Adjust how the image fits within the box
                ),
              ),

              SizedBox(height: 20),
              // Primary title text
              Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black
                ),
              ),
              SizedBox(height: 15),

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
              focusedIconPath: 'assets/images/icons/password_black.png',
                unfocusedIconPath: 'assets/images/icons/password_grey.png'
              ),
              SizedBox(height: 16.0),

              //sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: CustomPillButton(
                      text: 'LOGIN',
                      onPressed: () {
                        print("Button Pressed!");
                        signIn();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const NavigationPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),

              //Sign up text and button at the end
              Padding(
                padding: const EdgeInsets.only(top:150.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey, 
                      ),
                    ),
                    SizedBox(width: 8.0), 
                    GestureDetector(
                      onTap: () {
                        // Handle navigation or page change here
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => RegistPage()),
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF86D293), 
                        ),
                      ),
                    ),
                  ],
                ),
              )
              
            ],
          ),
        ),
      )
    );
  }
}