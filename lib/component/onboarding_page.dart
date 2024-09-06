import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final Image image;
  final String title;
  final String description;
  final int noOfScreen;
  final VoidCallback onNextPressed;
  final int currentScreenNo;
  final bool showSkipButton;
  final bool showNextButton;
  final bool showGetStartedButton;
  final VoidCallback? onSkipPressed;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.noOfScreen,
    required this.onNextPressed,
    required this.currentScreenNo,
    this.showSkipButton = false,
    this.showNextButton = false,
    this.showGetStartedButton = false,
    this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.height < 600; // Example breakpoint for small screens

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Limit the size of the image
              Container(
                constraints: BoxConstraints(
                  maxHeight: isSmallScreen ? 200 : 300, // Adjust height as needed
                ),
                child: image,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 22 : 28, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16, // Responsive description text
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        // Skip Button at the top-right corner
        if (showSkipButton)
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: onSkipPressed ?? () {},
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        // Bottom row for Next or Get Started
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (showNextButton)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: onNextPressed,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), // Circular shape
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.black, // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: const Center(
                      child: const Text(
                        '>',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ),
              if (showGetStartedButton)
                Expanded(
                  child: ElevatedButton(
                    onPressed: onNextPressed,
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
