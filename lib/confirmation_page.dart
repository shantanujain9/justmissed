import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String email;
  final String username;
  final String firstName;
  final String lastName;

  ConfirmationPage({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Confirmation Details:'),
            Text('Email: $email'),
            Text('Username: $username'),
            Text('First Name: $firstName'),
            Text('Last Name: $lastName'),
          ],
        ),
      ),
    );
  }
}
