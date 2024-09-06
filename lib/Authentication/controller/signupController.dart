import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayurvan/Authentication/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpController extends GetxController {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNo = TextEditingController(); // Added phone number controller

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function to handle email/password registration
  Future<void> registerUser(String fullName, String email, String password) async {
  try {
    // Trim email to remove any unintended spaces
    email = email.trim();
    
    // Print to debug
    print("Attempting to register user with email: $email");

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    print("User registered: ${userCredential.user?.email}");
    Get.offAll(() => const WelcomeScreen());

  } on FirebaseAuthException catch (e) {
    print("Error: ${e.message}");
    Get.snackbar('Error', e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM);
  }
}

  // Function to handle Google sign-in
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
        // Handle successful Google sign-in
        print("User signed in with Google: ${userCredential.user?.email}");
        Get.offAll(() => const WelcomeScreen()); // Navigate to WelcomeScreen
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      Get.snackbar('Error', e.message ?? 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Function to handle phone number registration
  Future<void> registerUserWithPhone(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-resolution of the code if the device supports it
          await _auth.signInWithCredential(credential);
          // Handle successful phone sign-in
          Get.offAll(() => const WelcomeScreen()); // Navigate to WelcomeScreen
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification error
          print("Error: ${e.message}");
          Get.snackbar('Error', e.message ?? 'An error occurred',
              snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationId, int? resendToken) {
          // Store the verification ID and resend token
          // You might want to prompt the user to enter the verification code sent to their phone
          // Save these values to verify the code later
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
          print("Verification code retrieval timeout");
        },
      );
    } catch (e) {
      // Handle exception
      print("Error: ${e.toString()}");
      Get.snackbar('Error', 'An unexpected error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Function to verify the OTP code sent to the phone
  Future<void> verifyOTP(String verificationId, String otpCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      await _auth.signInWithCredential(credential);
      // Handle successful phone sign-in
      Get.offAll(() => const WelcomeScreen()); // Navigate to WelcomeScreen
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      Get.snackbar('Error', e.message ?? 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
