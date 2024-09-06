import 'package:flutter/material.dart';
import 'package:ayurvan/screens/api.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var email = TextEditingController();
  var password = TextEditingController();

  Future<void> loginUserWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      // Notify the user of a successful login
      Get.snackbar(
        'Login Successful',
        'Welcome back, ${userCredential.user?.email}',
        snackPosition: SnackPosition.BOTTOM,
      );
      // Navigate to the appropriate screen after successful login
      Get.offAll(() => const ApiScreen());
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      Get.snackbar(
        'Login Error',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Handle any other unexpected errors
      Get.snackbar(
        'Login Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User aborted the Google sign-in
        Get.snackbar(
          'Login Error',
          'Google sign-in aborted by user.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Notify the user of a successful Google login
      Get.snackbar(
        'Login Successful',
        'Welcome back, ${userCredential.user?.displayName ?? 'User'}',
        snackPosition: SnackPosition.BOTTOM,
      );
      // Navigate to the appropriate screen after successful Google login
      Get.offAll(() => const ApiScreen());
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      Get.snackbar(
        'Login Error',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Handle any other unexpected errors
      Get.snackbar(
        'Login Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

