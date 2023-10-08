import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:justmissed/models/accept.dart';
import 'package:justmissed/screens/homepage.dart';

class ConfirmRequest extends StatefulWidget {
  @override
  _ConfirmRequestState createState() => _ConfirmRequestState();
}

class _ConfirmRequestState extends State<ConfirmRequest> {
  String firstName = '';
  String lastName = '';
  String instagramHandle = '';
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();

  bool isGreenButtonPressed = false;
  String profileImagePath = '';

  Future<void> _pickProfileImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = "l";
    return Scaffold(
      appBar: AppBar(
        title: Text('Two Buttons Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _pickProfileImage,
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: profileImagePath.isNotEmpty
                      ? FileImage(File(profileImagePath))
                      : null,
                  child: profileImagePath.isEmpty
                      ? Icon(
                          Icons.camera_alt,
                          size: 40.0,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _pickProfileImage,
                child: Text('Change Profile Picture'),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Text('First Name: $firstName'),
              ),
              Text('Last Name: $lastName'),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the login page when the button is pressed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcceptPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text(
                  'Accept',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the login page when the button is pressed
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(username),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text(
                  'Reject',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConfirmRequest(),
  ));
}
