import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ichat/common/snacker.dart';

import '../common/country_dialog.dart';
import '../common/phonefield/countries.dart';
import '../models/country.dart';

final loadingProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();

  String _selectedCountryCode = "";

  final List<Country> _countries = countriesMap
      .map((countryData) => Country(
          name: countryData['name'], code: countryData['dial_code'].toString()))
      .toList();

  bool resentCode = false;

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(loadingProvider);

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => CountryDialog(
                  countries: _countries,
                  onCountrySelected: (country) {
                    setState(() {
                      _selectedCountryCode = country.code!;
                    });
                    Navigator.pop(context);
                  },
                ),
              );
            },
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: "ISD Code",
                border: OutlineInputBorder(),
              ),
              child: Text(_selectedCountryCode),
            ),
          ),
        ),
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
