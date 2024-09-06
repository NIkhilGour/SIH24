import 'package:ayurvan/screens/home_page.dart';
import 'package:ayurvan/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayurvan/Authentication/repository/signUpemailFailure.dart';
import 'package:ayurvan/Authentication/screens/welcome_screen.dart';
import 'package:ayurvan/screens/api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  // Firebase Auth instance
  final _auth = FirebaseAuth.instance;

  // Reactive Firebase User
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    // Bind the user stream to react to auth state changes
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);  // React to user state changes
  }

  // Determine the initial screen based on auth state
  void _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const WelcomeScreen()); // Redirect to WelcomeScreen if no user is signed in
    } else {
      Get.offAll(() => const Tabs());  // Redirect to API Screen when user is signed in
    }
  }

  // Create a new user with email and password
  Future<void> createUserwithEmailandPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        'Signup Successful',
        'Account created. You can now log in.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(() => const ApiScreen());  // After signup, redirect to the API screen or homepage
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailandPasswordFailure.code(e.code);
      Get.snackbar('Signup Error', ex.message, snackPosition: SnackPosition.BOTTOM);
      throw ex;  // Rethrow the error for further handling if needed
    } catch (e) {
      final ex = SignUpWithEmailandPasswordFailure();
      Get.snackbar('Signup Error', ex.message, snackPosition: SnackPosition.BOTTOM);
      throw ex;
    }
  }

  // Log in with email and password
  Future<void> loginUserwithEmailandPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Login Successful', 'You are now logged in', snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => const Tabs());  // Redirect to the home screen upon login success
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Error', e.message ?? 'An error occurred', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Login Error', 'An unexpected error occurred', snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Sign in using Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in was canceled by the user.');
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);  // Return the UserCredential after successful Google sign-in
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Google Sign-in Error', e.message ?? 'An error occurred', snackPosition: SnackPosition.BOTTOM);
      throw e;
    } catch (e) {
      Get.snackbar('Google Sign-in Error', 'An unexpected error occurred', snackPosition: SnackPosition.BOTTOM);
      throw Exception('Sign-in failed: ${e.toString()}');
    }
  }

  // Log out from both Firebase and Google
  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut();  // Log out from Google
      await _auth.signOut();  // Log out from Firebase
      Get.offAll(() => const WelcomeScreen());  // Redirect to WelcomeScreen after logout
      Get.snackbar('Logout Successful', 'You have been logged out', snackPosition: SnackPosition.BOTTOM,backgroundColor: const Color.fromARGB(255, 146, 232, 149) );
    } catch (e) {
      Get.snackbar('Logout Error', 'An error occurred during logout', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
