import 'package:flutter/material.dart';
import 'package:justmissed/screens/confirmation_page.dart';

class RegistrationPage extends StatelessWidget {
  // Define variables to store user input
  String email = '';
  String username = '';
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email TextField
            TextFormField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),

            // Username TextField
            TextFormField(
              onChanged: (value) {
                username = value;
              },
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),

            // First Name TextField
            TextFormField(
              onChanged: (value) {
                firstName = value;
              },
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10),

            // Last Name TextField
            TextFormField(
              onChanged: (value) {
                lastName = value;
              },
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 20),

            // Register Button

            ElevatedButton(
              onPressed: () {
                // Perform registration logic here
                print('Email: $email');
                print('Username: $username');
                print('First Name: $firstName');
                print('Last Name: $lastName');

                // Navigate to the confirmation page and pass data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(
                      email: email,
                      username: username,
                      firstName: firstName,
                      lastName: lastName,
                    ),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
