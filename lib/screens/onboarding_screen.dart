import 'package:ayurvan/Authentication/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ayurvan/component/onboarding_page.dart'; // Update the import path as per your project structure.

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final LiquidController liquidController = LiquidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          // Onboarding Page 1 - Introduction to Virtual Herbal Garden
          Container(
            color: Colors.greenAccent.shade100,
            child: OnboardingPage(
              image: Image.asset("assets/images/herbal_garden.png"),
              title: "Welcome to Virtual Herbal Garden",
              description: "Explore the rich world of medicinal plants used in AYUSH. Learn their benefits, history, and uses.",
              noOfScreen: 3,
              onNextPressed: () => liquidController.animateToPage(page: 1), // Added `onNextPressed`
              currentScreenNo: 0,
              showSkipButton: true,
              showNextButton: true,
              onSkipPressed: () => openHomeScreen(context),
            ),
          ),

          // Onboarding Page 2 - Interactive Exploration
          Container(
            color: Colors.greenAccent.shade100,
            child: OnboardingPage(
              image: Image.asset("assets/images/3d.png"),
              title: "Explore in 3D",
              description: "Experience plants in an immersive 3D environment. Rotate, zoom, and learn about each plant’s unique features.",
              noOfScreen: 3,
              onNextPressed: () => liquidController.animateToPage(page: 2), // Added `onNextPressed`
              currentScreenNo: 1,
              showSkipButton: true,
              showNextButton: true,
              onSkipPressed: () => openHomeScreen(context),
            ),
          ),

          // Onboarding Page 3 - AYUSH AI Bot
          Container(
            color: Colors.greenAccent.shade100,
            child: OnboardingPage(
              image: Image.asset("assets/images/chatbot.png"),
              title: "Meet AYUSH AI Bot",
              description: "Our AI assistant helps you discover the benefits of medicinal plants. Ask questions and get detailed answers.",
              noOfScreen: 3,
              onNextPressed: () => openHomeScreen(context), // Added `onNextPressed`
              currentScreenNo: 2,
              showGetStartedButton: true,
            ),
          ),
        ],
        liquidController: liquidController,
        enableLoop: false,
        slideIconWidget: const Icon(Icons.arrow_back_ios),
        positionSlideIcon: 0.8,
        fullTransitionValue: 400,
        waveType: WaveType.liquidReveal,
      ),
    );
  }

  void openHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }
}
