import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ayurvan/Authentication/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:ayurvan/firebase_options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set the animation controller to 4 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward(); // Start the animation
    initializeApp(); // Initialize Firebase and delay splash screen
  }

  Future<void> initializeApp() async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      // Delay for 5 seconds to allow splash screen to show
      await Future.delayed(const Duration(seconds: 5));
      
      // Check if widget is still mounted before navigating
      if (mounted) {
        Get.off(() => const WelcomeScreen()); // Navigate to WelcomeScreen
      }
    } catch (e) {
      print('Error during Firebase initialization: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            // Gradient background from top-left green to bottom-right white
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green, Colors.white],
            ),
          ),
          child: FadeTransition(
            opacity: _animation, // Fade animation for splash screen
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo image for splash screen
                  Image.asset(
                    'assets/images/icon.jpg', // Ensure the path is correct
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  // Circular progress indicator
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
