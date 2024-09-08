import 'package:ayurvan/core/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RevolvingImages(),
    );
  }
}

class RevolvingImages extends StatefulWidget {
  const RevolvingImages({super.key});

  @override
  _RevolvingImagesState createState() => _RevolvingImagesState();
}

class _RevolvingImagesState extends State<RevolvingImages>
    with TickerProviderStateMixin {
 late AnimationController _moveInController;
 late AnimationController _revolveController;
 late Animation<double> _moveInAnimation;

  @override
  void initState() {
    super.initState();

    // Controller for the images moving into position
    _moveInController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Time for images to move into the screen
    );

    _moveInAnimation = CurvedAnimation(
      parent: _moveInController,
      curve: Curves.easeInOut, // Smooth ease-in and ease-out effect
    );

    // Controller for the revolving animation
    _revolveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Speed of the revolution
    )..repeat(); // Infinite repeat

    // Start the move-in animation
    _moveInController.forward().then((_) {
      // Once the move-in is complete, start revolving
      _revolveController.repeat();
    });
  }

  @override
  void dispose() {
    _moveInController.dispose();
    _revolveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 100; // Final radius for images around the center

    return Scaffold(
     backgroundColor:tilecolor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Central image
            Image.asset(
              'assets/images/a-6.png', // Your central image path
              width: 100,
              height: 100,
            ),
            // Revolving images
            for (int i = 0; i < 5; i++)
              AnimatedBuilder(
                animation: Listenable.merge([_moveInAnimation, _revolveController]),
                builder: (context, child) {
                  // Calculate the revolving angle (revolves with time)
                  final revolveAngle = (i * 2 * pi / 5) + _revolveController.value * 2 * pi;

                  // Move the images in from outside the screen (starts at 0 and scales to final position)
                  final offset = Offset(
                    _moveInAnimation.value * radius * cos(revolveAngle),
                    _moveInAnimation.value * radius * sin(revolveAngle),
                  );

                  return Transform.translate(
                    offset: offset,
                    child: Image.asset(
                      'assets/images/a-${i+1}.png', // Paths for the revolving images
                      width: 50,
                      height: 50,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
