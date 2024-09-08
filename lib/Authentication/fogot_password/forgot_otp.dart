import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ayurvan/constant/Text.dart';
import 'package:ayurvan/constant/size.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({required this.verificationId, super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _auth = FirebaseAuth.instance;

  Future<void> _verifyOtp(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP verified successfully!'),
        ),
      );
      // Navigate to the next screen or handle post-login logic here
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to verify OTP: $e'),
        ),
      );
    }
  }

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
            const Text(
              tOtpSubTitle,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
            const SizedBox(height: 40),
            const Text(
              'Enter the OTP sent to your phone number',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(.08),
              filled: true,
              keyboardType: TextInputType.number,
              onSubmit: (code) {
                _verifyOtp(code);
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // You might want to handle manual OTP input or other logic here
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
