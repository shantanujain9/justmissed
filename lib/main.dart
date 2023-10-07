import 'package:flutter/material.dart';
import 'package:justmissed/screens/login.dart';
import 'package:justmissed/screens/confirmation_page.dart';
import 'package:justmissed/screens/registration_page.dart';

void main() {
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
