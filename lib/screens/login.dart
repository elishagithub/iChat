import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Trigger the phone number authentication flow
            _startPhoneNumberVerification(context);
          },
          child: const Text('Login with Phone Number'),
        ),
      ),
    );
  }

  Future<void> _startPhoneNumberVerification(BuildContext context) async {
    final TextEditingController phoneNumberController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Phone Number'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Validate and submit the phone number for verification
                final phoneNumber = phoneNumberController.text.trim();
                if (phoneNumber.isNotEmpty) {
                  await _verifyPhoneNumber(context, phoneNumber);
                }
              },
              child: const Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of the verification code completed.
        // Sign the user in with the credential here (e.g., _auth.signInWithCredential(credential))
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        if (kDebugMode) {
          print('Verification failed: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // Navigate to the OTP verification page and pass the verification ID
        context.go('/otp_verification?verificationId=$verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Timeout for auto-retrieval of the verification code
      },
    );
  }
}
