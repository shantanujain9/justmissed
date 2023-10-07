import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = ''; // Initialize with an empty first name
  String lastName = ''; // Initialize with an empty last name
  String instagramHandle = ''; // Initialize with an empty Instagram handle
  String profileImagePath = ''; // Initialize with an empty profile image path
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();

  // Function to pick an image from the gallery
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Profile Picture
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: profileImagePath.isNotEmpty
                    ? FileImage(File(profileImagePath))
                    : const AssetImage('assets/default_profile.png') as ImageProvider,
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: _pickProfileImage,
              child: const Text('Change Profile Picture'),
            ),
            const SizedBox(height: 20.0),

            // First Name
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              onChanged: (value) {
                setState(() {
                  firstName = value;
                });
              },
            ),
            const SizedBox(height: 20.0),

            // Last Name
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              onChanged: (value) {
                setState(() {
                  lastName = value;
                });
              },
            ),
            const SizedBox(height: 20.0),

            // Instagram Handle
            TextFormField(
              controller: instagramController,
              decoration:
                  const InputDecoration(labelText: 'Instagram Handle (optional)'),
              onChanged: (value) {
                setState(() {
                  instagramHandle = value;
                });
              },
            ),
            const SizedBox(height: 20.0),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Implement logic to save the user's profile information
                // You can use the values of firstName, lastName, instagramHandle, and profileImagePath here.
              },
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
