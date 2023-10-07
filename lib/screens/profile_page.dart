import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:justmissed/screens/login.dart';

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
  File? profileImage; // Store the selected profile image
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();

  // Function to pick an image from the gallery
  Future<void> _pickProfileImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path); // Store the selected image file
      });
    }
  }

  // Method to build the profile picture widget
Widget _buildProfilePicture() {
  return Column(
    children: [
      CircleAvatar(
        radius: 60.0,
        backgroundColor: Colors.red,
        child: profileImage != null
            ? null // No child when an image is selected
            : Icon(
                Icons.person, // You can use any appropriate icon here
                size: 60.0,
                color: Colors.white, // You can set the icon color
              ),
        backgroundImage: profileImage != null
            ? null
            : null, // Use null for the backgroundImage if no image is selected
      ),
      const SizedBox(height: 10.0),
      Text(
        '$firstName $lastName',
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ],
  );
}




  void _logout() {
    // Implement logout logic here, such as clearing user data, etc.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You have been logged out.'),
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
              child: _buildProfilePicture(),
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
                  // You can use the values of firstName, lastName, instagramHandle, and profileImage here.

                  // Show a confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Changes have been saved.'),
                    ),
                  );
                } else {
                  // Show an error message or alert to inform the user that first name and last name are mandatory.
                  // You can use a Snackbar or showDialog for this.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in the required fields.'),
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
