import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _validateInput() {
    return firstName.isNotEmpty && lastName.isNotEmpty;
  }

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

  void _logout() {
    // Implement logout logic here, such as clearing user data, etc.
    Navigator.of(context).pop(); // Go back to the previous screen (login page)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('You have been logged out.'),
      ),
    );
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
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: profileImagePath.isNotEmpty
                        ? FileImage(File(profileImagePath))
                        : const AssetImage('assets/default_profile.png')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '$firstName $lastName',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),

            // Instagram Handle
            TextFormField(
              controller: instagramController,
              decoration: const InputDecoration(
                  labelText: 'Instagram Handle (optional)'),
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
                if (_validateInput()) {
                  // First name and last name are not empty, implement logic to save the user's profile information
                  // You can use the values of firstName, lastName, instagramHandle, and profileImagePath here.

                  // Show a confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Changes have been saved.'),
                    ),
                  );
                } else {
                  // Show an error message or alert to inform the user that first name and last name are mandatory.
                  // You can use a Snackbar or showDialog for this.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please fill in the required fields.'),
                    ),
                  );
                }
              },
              child: const Text('Save Profile'),
            ),

            // Logout Button
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
