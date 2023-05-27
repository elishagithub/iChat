import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:ichat/constants.dart';

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
              // Arrow
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

              // Empty space
              Expanded(flex: 2, child: Container()),

              // Hi! message
              const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Hi!",
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),

              // login card
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            color: Colors.grey.shade200.withOpacity(0.2),
                          ),

                          // Column with field and login buttons
                          child: Column(
                            children: [
                              // Mobile number field
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: TextField(
                                  // controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,

                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                  ),
                                ),
                              ),

                              // Continue button
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle continue button press
                                    // String phoneNumber = _phoneNumberController.text;
                                    // Perform desired actions with the phone number
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.pink,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0))),
                                      minimumSize: const Size.fromHeight(48)),
                                  child: const Text(
                                    'Continue',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),

                              // or
                              const Padding(
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: Center(
                                    child: Text('or',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ),

                              //  Continue with Facebook
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0, bottom: 16.0),
                                child: facebookButton(),
                              ),

                              // Continue with Google
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: googleButton(),
                              ),

                              // Continue with Apple
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: appleButton(),
                              ),


                              // Continue with Phone
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: phoneButton(),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
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

ElevatedButton facebookButton() {
  return ElevatedButton(
    onPressed: () {
      // Handle Facebook button press
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.blue,
      backgroundColor: Colors.white,
      minimumSize: const Size.fromHeight(48),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    child: const Row(
      children: [
        Icon(Icons.facebook,
        size: 32,),
        Expanded(
          child: Text(
            'Continue with Facebook',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

ElevatedButton appleButton() {
  return ElevatedButton(
    onPressed: () {
      // Handle Facebook button press
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      minimumSize: const Size.fromHeight(48),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    child: const Row(
      children: [
        Icon(Icons.apple,
        size: 32,),
        Expanded(
          child: Text(
            'Continue with Apple',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

ElevatedButton googleButton() {
  return ElevatedButton(
    onPressed: () {
      // Handle Google button press
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.blue,
      backgroundColor: Colors.white,
      minimumSize: const Size.fromHeight(48),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    child: Row(
      children: <Widget>[
        Image.network(
          'http://pngimg.com/uploads/google/google_PNG19635.png',
          height: 32.0,
          width: 32.0,
        ),
        const Expanded(
          child: Text(
            'Continue with Google',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

ElevatedButton phoneButton() {
  return ElevatedButton(
    onPressed: () {
      // Handle Phone button press
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.blue,
      backgroundColor: Colors.white,
      minimumSize: const Size.fromHeight(48),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    child: Row(
      children: <Widget>[
        Image.asset(
          'assets/images/phone.png', // Replace with your flag asset path
          height: 32,
          width: 32,
        ),
        const Expanded(
          child: Text(
            'Continue with Phone',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
