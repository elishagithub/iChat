import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ichat/common/snacker.dart';

final loadingProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();

  bool resentCode = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(loadingProvider);

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Enter Phone Number',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () async {
              final phoneNumber = phoneNumberController.text.trim();
              if (phoneNumber.isNotEmpty) {
                await verifyPhoneNumber(context, phoneNumber, ref);
              }
            },
            child: isLoading
                ? const SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)))
                : const Text("Login")),
      ],
    ));
  }

  Future<void> verifyPhoneNumber(
      BuildContext context, String phoneNumber, WidgetRef ref) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    ref.read(loadingProvider.notifier).state = true;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of the verification code completed.
        // Sign the user in with the credential here (e.g., _auth.signInWithCredential(credential))
      },
      verificationFailed: (FirebaseAuthException e) {
        Snacker.showSnack(context, e.message.toString());

        // Handle verification failure
        if (kDebugMode) {
          print('Verification failed: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        ref.read(loadingProvider.notifier).state = false;
        // Navigate to the OTP verification page and pass the verification ID
        context.go('/otp_verification?verificationId=$verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Timeout for auto-retrieval of the verification code
      },
    );
  }
}
