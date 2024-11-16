import 'package:flutter/material.dart';
import 'package:zip_recipes_app/auth/login.dart';

import '../widgets/custom_pill_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPwd extends StatefulWidget {
  const ForgotPwd({super.key});

  @override
  State<ForgotPwd> createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
                // Primary title text
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.black
                  ),
                ),
                const SizedBox(height: 15),

                // Secondary title text
                const Text(
                  'Please insert your email',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF8E8E8E)
                  ),
                ),
                const SizedBox(height: 25),

                //email textfield
                CustomTextField(
                    controller: _emailController,
                    hintText: 'EMAIL',
                    focusedIconPath: 'assets/images/icons/email_black.png',
                    unfocusedIconPath: 'assets/images/icons/email_grey.png'
                ),
                const SizedBox(height: 16.0),

                //sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: CustomPillButton(
                        text: 'SEND',
                        onPressed: () {
                          print("Button Pressed!");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 70.0),


                //Sign up text and button at the end
                Padding(
                  padding: const EdgeInsets.only(top:150.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Go back?",
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
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
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
        )
    );
  }
}
