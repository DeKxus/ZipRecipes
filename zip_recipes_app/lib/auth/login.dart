import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zip_recipes_app/auth/forgot_pwd.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordEmpty = ValueNotifier(true);

  Future signIn() async {
    try {
      // Authenticate user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
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
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      _isPasswordEmpty.value = _passwordController.text.isEmpty;
    });
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
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),

              // Logo image
              SizedBox(
                width: 160.0,
                height: 130.0,
                child: Image.asset(
                  'assets/images/logos/logo.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Please sign in to continue',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF8E8E8E),
                ),
              ),
              const SizedBox(height: 25),

              // Email textfield
              CustomTextField(
                controller: _emailController,
                hintText: 'EMAIL',
                focusedIconPath: 'assets/images/icons/email_black.png',
                unfocusedIconPath: 'assets/images/icons/email_grey.png',
              ),
              const SizedBox(height: 16.0),

              // Password textfield with "FORGOT" text
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'PASSWORD',
                    obscureText: true,
                    focusedIconPath: 'assets/images/icons/password_black.png',
                    unfocusedIconPath: 'assets/images/icons/password_grey.png',
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isPasswordEmpty,
                    builder: (context, isEmpty, child) {
                      return Visibility(
                        visible: isEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgotPwd()),
                              );
                            },
                            child: const Text(
                              "FORGOT",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF86D293),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: CustomPillButton(
                      text: 'LOGIN',
                      onPressed: () {
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

              // Sign up text and button at the end
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const RegistPage()),
                        );
                      },
                      child: const Text(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
