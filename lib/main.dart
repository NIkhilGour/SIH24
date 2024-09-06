import 'package:ayurvan/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:ayurvan/Authentication/repository/authentication_repo.dart';
import 'package:ayurvan/Authentication/screens/welcome_screen.dart';
import 'package:ayurvan/Authentication/screens/splash_screen.dart';
import 'package:ayurvan/firebase_options.dart';
import 'package:ayurvan/util/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
       .then((value) => Get.put(AuthenticationRepo()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Login Demo',
      theme: TAppTheme.lightTheme, // Your custom light theme
      darkTheme: TAppTheme.darkTheme, // Custom dark theme
      themeMode: ThemeMode.system, // Automatically switch based on system setting
      home: const SplashScreen(), // Start with the SplashScreen
    );
  }
}


