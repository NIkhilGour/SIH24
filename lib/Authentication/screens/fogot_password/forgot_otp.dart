import 'package:flutter/material.dart';
import 'package:ayurvan/constant/Text.dart';
import 'package:ayurvan/constant/size.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tOtpTitle,
              style: GoogleFonts.montserrat(
                  fontSize: 80, fontWeight: FontWeight.bold),
            ),
            const Text(tOtpSubTitle,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '$tOtpMessage RahulMeena626441@gmail.com',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(.08),
              filled: true,
              keyboardType: TextInputType.number,
              onSubmit: (code) {
                print('Otp is the $code');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
