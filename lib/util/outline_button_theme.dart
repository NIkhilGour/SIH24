import 'package:flutter/material.dart';
import 'package:ayurvan/constant/color.dart';

class TOutLinedButtonTheme {
  TOutLinedButtonTheme._();
  static final lightOutlinedButtonTheme =
      OutlinedButtonThemeData( style : OutlinedButton.styleFrom(

        
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40))),
    foregroundColor: tSecondaryColor,
   
    fixedSize: const Size(10, 20),
    side: const BorderSide(color: tSecondaryColor),
  )
  );
  static final darkOutlinedButtonTheme =OutlinedButtonThemeData( 
   style : OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40))),
    foregroundColor: tSecondaryColor,
    backgroundColor: Colors.white,
    fixedSize: const Size(10, 20),
    side: const BorderSide(color: tSecondaryColor),
  ));
}