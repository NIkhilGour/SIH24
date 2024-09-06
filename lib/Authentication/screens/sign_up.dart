import 'package:flutter/material.dart';
import 'package:ayurvan/Authentication/controller/signupController.dart';
import 'package:ayurvan/Authentication/screens/login.dart';
import 'package:ayurvan/constant/Text.dart';
import 'package:ayurvan/constant/image.dart';
import 'package:ayurvan/constant/size.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late SignUpController controller;
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SignUpController());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Header Image
              Image(
                image: const AssetImage(tWelcomeScreenImage),
                height: height * 0.2,
              ),
              const SizedBox(height: 20), // Added spacing
              const Text(
                tSingUpTilte,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8), // Added spacing
              const Text(
                tSignUpSubTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

              // Section 2: Sign-Up Form
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field
                      TextFormField(
                        controller: controller.fullname,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          labelText: 'Full Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Email Field
                      TextFormField(
                        controller: controller.email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'E-Mail',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Phone Number Field
                      TextFormField(
                        controller: controller.phoneNo,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone_outlined),
                          labelText: 'Phone Number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                           else if (!value.isPhoneNumber ) {
                            return 'Please enter valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Password Field
                      TextFormField(
                        controller: controller.password,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6 || !value.isPassport) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              controller.registerUser(
                                  controller.fullname.text,
                                  controller.email.text
                                      .trim(), // Ensure email is trimmed
                                  controller.password.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                 const Color(0xFF618867),
                            fixedSize: const Size(200, 50),
                          ),
                          child: Text(
                            tsignup.toUpperCase(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Already have an account Text
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Already have an account? Login'),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Google Sign-In Button
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('OR'),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(200, 50),
                              ),
                              icon: const Image(
                                image: AssetImage(tGoogleLogo),
                                height: 20,
                                width: 20,
                              ),
                              onPressed: () {
                                controller.signInWithGoogle();
                              },
                              label: const Text(
                                'Sign-In With Google',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
