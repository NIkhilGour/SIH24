import 'package:flutter/material.dart';
import 'package:ayurvan/Authentication/screens/sign_up.dart';
import 'package:ayurvan/constant/Text.dart';
import 'package:ayurvan/constant/image.dart';
import 'package:ayurvan/constant/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Initialize GoogleSignIn

  bool _isPasswordVisible = false; // Manage the visibility of the password

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1
                Image(
                  image: const AssetImage(tWelcomeScreenImage),
                  height: height * 0.2,
                ),
                const Text(
                  tLoginTitle,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                const Text(
                  tLoginSubTitle,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),

                // Section 2
                Form(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: 'E-Mail',
                            hintText: 'E-Mail',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible, // Toggle password visibility
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: "Password",
                            hintText: 'Password',
                            border: const OutlineInputBorder(),
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
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password logic here
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              signInWithEmailAndPassword();
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 50),
                            ),
                            child: Text(
                              tlogin.toUpperCase(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('OR'),
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
                                  signInWithGoogle();
                                },
                                label: const Text(
                                  'Sign-In With Google',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                dontHaveAcc(context);
                              },
                              child: const Text.rich(
                                TextSpan(
                                  text: 'Don\'t have an Account?',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(245, 105, 102, 102),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' Sign Up',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
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
      ),
    );
  }

  void dontHaveAcc(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Handle successful login here
      print("User logged in: ${userCredential.user?.email}");
      // Navigate to the home screen or dashboard
    } on FirebaseAuthException catch (e) {
      // Handle error here
      print("Error: ${e.message}");
      // You can display a snackbar or dialog with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // Handle successful login here
        print("User signed in with Google: ${userCredential.user?.email}");
        // Navigate to the home screen or dashboard
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    }
  }
}
