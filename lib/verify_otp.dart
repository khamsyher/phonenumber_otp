import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phonenumber_otp/number_screen.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  OTPPage({required this.phoneNumber, required this.verificationId});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  TextEditingController _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap with MaterialApp
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Enter OTP:',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'OTP'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: _otpController.text,
                    );

                    // Sign the user in (or link) with the credential
                    await _auth.signInWithCredential(credential);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneNumberPage()),
                    );
                  },
                  child: const Text('send code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
