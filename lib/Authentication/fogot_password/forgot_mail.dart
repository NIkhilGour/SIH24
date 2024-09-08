import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ayurvan/constant/Text.dart';
import 'package:ayurvan/constant/image.dart';
import 'package:ayurvan/constant/size.dart';

class ForgotPasswordMailScreen extends StatefulWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  _ForgotPasswordMailScreenState createState() => _ForgotPasswordMailScreenState();
}

class _ForgotPasswordMailScreenState extends State<ForgotPasswordMailScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _sendPasswordResetEmail(BuildContext context, String email) async {
    if (!_isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
        ),
      );
      return;
    }

    try {
      final normalizedEmail = email.toLowerCase();

      // Send the password reset email
      await _auth.sendPasswordResetEmail(email: normalizedEmail);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password reset email sent. Please check your inbox.'),
          backgroundColor: Colors.green,  // Green background for success
        ),
      );
    } catch (e) {
      print('Error sending password reset email: $e');  // Added detailed logging
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send password reset email: $e'),
          backgroundColor: Colors.red,  // Red background for error
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: defaultSize + 4),
                Image(
                  image: const AssetImage(tForgotPassWordImage),
                  height: height * 0.2,
                ),
                const SizedBox(height: 30),
                const Text(
                  tForgotPassword,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                const Text(
                  tForgotEmailSubtitle,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: defaultSize),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 25),
                        decoration: const InputDecoration(
                          label: Text('E-mail'),
                          hintText: 'E-mail',
                          border: OutlineInputBorder(),
                          prefix: Icon(Icons.mail_outline_rounded, size: 30),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text.trim();
                      _sendPasswordResetEmail(context, email);
                    },
                    style: ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
