import 'package:flutter/material.dart';
import 'package:justmissed/screens/confirmation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Define variables to store user input
  String email = '';
  String username = '';
  String firstName = '';
  String lastName = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to validate email format
  bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    }
    // You can use a regular expression to validate the email format
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Email TextField
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!isValidEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Username TextField
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // First Name TextField
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    firstName = value;
                  });
                },
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Last Name TextField
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    lastName = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform registration logic here
                    print('Email: $email');
                    print('Username: $username');
                    print('First Name: $firstName');
                    print('Last Name: $lastName');

                    // Save data to Firestore
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('users');
                    users.add({
                      'email': email,
                      'username': username,
                      'firstName': firstName,
                      'lastName': lastName
                    }).then((value) {
                      print("User Added");
                    }).catchError((error) {
                      print("Failed to add user: $error");
                    });

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
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
