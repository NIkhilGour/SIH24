import 'package:flutter/material.dart';
import 'package:ayurvan/util/button_theme.dart';
import 'package:ayurvan/util/outline_button_theme.dart';
import 'package:ayurvan/util/text_field_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xFFFFE200, <int, Color>{
      50: Color(0x1AFFE200),
      100: Color(0x33FFE200),
      200: Color(0x4DFFE200),
      300: Color(0x66FFE200),
      400: Color(0x80FFE200),
      500: Color(0xFFFFE200),
      600: Color(0x99FFE200),
      700: Color(0x83FFE200),
      800: Color(0xCCFFE200),
      900: Color(0xE6FFE200),
    }),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.montserrat(
        color: Colors.black87,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Colors.black54,
        fontSize: 24,
      ),
    ),

    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutLinedButtonTheme.lightOutlinedButtonTheme
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: const MaterialColor(0xFFFFE200, <int, Color>{
      50: Color(0x1AFFE200),
      100: Color(0x33FFE200),
      200: Color(0x4DFFE200),
      300: Color(0x66FFE200),
      400: Color(0x80FFE200),
      500: Color(0xFFFFE200),
      600: Color(0x99FFE200),
      700: Color(0x83FFE200),
      800: Color(0xCCFFE200),
      900: Color(0xE6FFE200),
    }),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.montserrat(
        color: Colors.white70,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Colors.white54,
        fontSize: 24,
      ),
    ),
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme
    ,
    outlinedButtonTheme: TOutLinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecoration,
  );

  static final ThemeData mealtheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 131, 57, 0),
    ),
    textTheme: GoogleFonts.latoTextTheme(),
     inputDecorationTheme: TTextFormFieldTheme.darkInputDecoration,

  );
}
