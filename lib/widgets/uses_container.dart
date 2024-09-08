import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsesContainer extends StatelessWidget {
  const UsesContainer({super.key, required this.uses});
  final String uses;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 20,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.green, style: BorderStyle.solid, width: 1.5),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Text(
              uses,
              style: GoogleFonts.lato(
                color: Colors.pink,
                fontWeight: FontWeight.w600,
                fontSize: 17
              ),
              // style: const TextStyle(
              //     color: Colors.pink,
              //     fontSize: 17,
              //     fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
