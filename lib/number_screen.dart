import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phonenumber_otp/verify_otp.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String _selectedCountryCode = '+856'; // Default country code

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Verify Phone Number'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Enter your phone number:',
                style: TextStyle(fontSize: 16.0),
              ),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixText: _selectedCountryCode,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_phoneNumberController.text.length == 10) {
                    try {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:
                            '$_selectedCountryCode${_phoneNumberController.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          print("Verification completed");
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          print("Verification failed: ${e.message}");
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPPage(
                                phoneNumber:
                                    '$_selectedCountryCode${_phoneNumberController.text}',
                                verificationId: verificationId,
                              ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print("Code auto retrieval timeout");
                        },
                      );
                    } catch (e) {
                      print("Error: $e");
                    }
                  } else {
                    print("Invalid phone number length");
                  }
                },
                child: const Text('Verify Phone Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
