import 'package:ayurvan/Authentication/repository/authentication_repo.dart';
import 'package:ayurvan/core/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
         onTap: () async {
              // Use the logout method from the AuthenticationRepo
              await AuthenticationRepo.instance.logOut();
            },
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: buttoncolor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Center(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
