import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers.dart';

class OTPVerificationPage extends ConsumerWidget {
  final String verificationId;

  const OTPVerificationPage({Key? key, required this.verificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(loadingProvider);

    final TextEditingController otpController = TextEditingController();

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
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform OTP verification and login logic
                _verifyOTP(context, otpController.text.trim(), ref);
              },
              child: isLoading
                  ? const SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)))
                  : const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOTP(
      BuildContext context, String otp, WidgetRef ref) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      ref.read(loadingProvider.notifier).state = true;

      // Sign in with the credential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        ref.read(loadingProvider.notifier).state = false;
        // Verification successful, navigate to the home page or perform any desired actions
        // ignore: use_build_context_synchronously
        context.go('/');
      });
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
