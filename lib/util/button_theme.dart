import 'package:flutter/material.dart';
import 'package:ayurvan/constant/color.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();
  static final lightElevatedButtonTheme =
      ElevatedButtonThemeData( style :ElevatedButton.styleFrom(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40))),
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xFF618867),
    fixedSize: const Size(10, 20),
    side: const BorderSide(color: tSecondaryColor),
  )
  );
  static final darkElevatedButtonTheme =ElevatedButtonThemeData( 
   style : ElevatedButton.styleFrom(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40))),
    foregroundColor:  const Color(0xFF618867),
    backgroundColor: Colors.white,
    fixedSize: const Size(10, 20),
    side: const BorderSide(color: tSecondaryColor),
  ));
}
