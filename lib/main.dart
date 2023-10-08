import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:justmissed/screens/login.dart';

final FirebaseOptions firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyBXKOV-t-E_wyQQdXTWGzp9oKH-uvZHpbA",
    authDomain: "justmissed-ae374.firebaseapp.com",
    projectId: "justmissed-ae374",
    storageBucket: "justmissed-ae374.appspot.com",
    messagingSenderId: "498627684982",
    appId: "1:498627684982:web:b42d7f4c31712b48f24d57",
    measurementId: "G-RE2QRW9F1C");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig).catchError((error) {
    print('Initialization error: $error');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
