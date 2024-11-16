import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zip_recipes_app/auth/login.dart';
import 'package:zip_recipes_app/home/select_plan.dart';
import 'package:zip_recipes_app/widgets/custom_pill_button.dart';
import 'package:zip_recipes_app/widgets/custom_text_field.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({super.key});

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      try {
        //create user
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;
        if (user != null) {
          //add user details
          await addUserDetails(
            user.uid,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _emailController.text.trim(),
          );

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectPlan())
          );
        }
      } catch (e) {
        // Registration failed, show error message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Registration Failed"),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Registration fail alert
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Registration Failed"),
            content: Text("Please make sure the passwords match."),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> addUserDetails(String uid, String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() == _confirmPasswordController.text.trim();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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
              SizedBox(height: 50.0),
              // Logo image
              SizedBox(
                width: 160.0, 
                height: 130.0, 
                child: Image.asset(
                  'assets/images/logos/logo.png', 
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              // Primary title text
              Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black
                ),
              ),
              const SizedBox(height: 30.0),
              //first name textfield
              CustomTextField(
                controller: _firstNameController, 
                hintText: 'FIRST NAME', 
                focusedIconPath: 'assets/images/icons/user_black.png',
                unfocusedIconPath: 'assets/images/icons/user_grey.png'
              ),
              const SizedBox(height: 16.0),
              //last name textfield
              CustomTextField(
                controller: _lastNameController, 
                hintText: 'LAST NAME', 
                focusedIconPath: 'assets/images/icons/user_black.png',
                unfocusedIconPath: 'assets/images/icons/user_grey.png'
              ),
              const SizedBox(height: 16.0),
              //email textfield
              CustomTextField(
                controller: _emailController, 
                hintText: 'EMAIL', 
                focusedIconPath: 'assets/images/icons/email_black.png',
                unfocusedIconPath: 'assets/images/icons/email_grey.png'
              ),
              const SizedBox(height: 16.0),
              //password textfield
              CustomTextField(
                controller: _passwordController, 
                hintText: 'PASSWORD', 
                obscureText: true,
                focusedIconPath: 'assets/images/icons/password_black.png',
                unfocusedIconPath: 'assets/images/icons/password_grey.png'
              ),
              const SizedBox(height: 16.0),
              //confirm password textfield
              CustomTextField(
                controller: _confirmPasswordController, 
                hintText: 'CONFIRM PASSWORD', 
                obscureText: true,
                focusedIconPath: 'assets/images/icons/password_black.png',
                unfocusedIconPath: 'assets/images/icons/password_grey.png'
              ),
              const SizedBox(height: 16.0),
              //regist button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: CustomPillButton(
                      text: 'SIGN UP',
                      onPressed: () {
                        print("Button Pressed!");
                        signUp();
                      },
                    ),
                  ),
                ],
              ),
              //Sign up text and button at the end
              Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Sign in",
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
      ),
    );
  }
}