import 'package:flutter/material.dart';
import 'package:ayurvan/constant/color.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();


  static InputDecorationTheme lightInputDecoration= const InputDecorationTheme(
                             
                              border: OutlineInputBorder(),
                              prefixIconColor: Colors.black,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2,color: tSecondaryColor)
                              )
                            );

 static InputDecorationTheme darkInputDecoration= const InputDecorationTheme(
                             
                              border: OutlineInputBorder(),
                              prefixIconColor: tPrimaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2,color: tPrimaryColor)
                              )
                  
                            );


}
