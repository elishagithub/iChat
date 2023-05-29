import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:ichat/constants.dart';

import '../my_app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            Constants.backgroundImage,
            fit: BoxFit.fill,
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Expanded(flex: 2, child: Container()),
              const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Hi",
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.grey.shade200.withOpacity(0.25)),
                            child: Center(
                              child: Text(
                                'Frosted',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    ));
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
