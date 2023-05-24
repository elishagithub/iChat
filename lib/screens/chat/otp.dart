import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPVerificationPage extends StatelessWidget {
  final String verificationId;

  const OTPVerificationPage({Key? key, required this.verificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform OTP verification and login logic
                _verifyOTP(context, _otpController.text.trim());
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOTP(BuildContext context, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Verification successful, navigate to the home page or perform any desired actions
      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      // Handle verification failure
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Verification Failed'),
            content: const Text('Invalid OTP. Please try again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
