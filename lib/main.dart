import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phonenumber_otp/number_screen.dart';
import 'package:phonenumber_otp/upload.dart';
import 'package:phonenumber_otp/upload_multiImagePicker/upload_multiImagePickerView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAar6jSoYy4lbKZ4OzPkw-5Lm28tWFl9hE",
        appId: "1:674766420402:android:ed48146c929d0f1cbd4cab",
        messagingSenderId: "674766420402",
        projectId: "test-dd635",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'otp authention Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyImagePickerWidget(),
    );
  }
}
