import 'package:ayurvan/core/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,

      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration:  BoxDecoration(
            color: selectedicon
          ),

         
        ),
      ),
    );
  }
}