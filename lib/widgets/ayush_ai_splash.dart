import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AyushAiSplash extends StatefulWidget {
  const AyushAiSplash({super.key});

  @override
  _AyushAiSplashState createState() => _AyushAiSplashState();
}

class _AyushAiSplashState extends State<AyushAiSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    // Use Tween to create a scaling effect (0.8x to 1.2x)
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value, // Scaling animation
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/icons/ayushAi.jpg', // Replace with your image path
                  height: 200,
                  width: 200,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
