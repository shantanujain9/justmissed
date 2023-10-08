import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePictureWidget extends StatefulWidget {
  final Function(String) onProfileImageChanged;
  final String initialImagePath;

  ProfilePictureWidget({
    required this.onProfileImageChanged,
    this.initialImagePath = '',
  });

  @override
  _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  String profileImagePath = '';

  @override
  void initState() {
    super.initState();
    profileImagePath = widget.initialImagePath;
  }

  Future<void> _pickProfileImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImagePath = pickedFile.path;
        widget.onProfileImageChanged(profileImagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickProfileImage,
      child: CircleAvatar(
        radius: 100.0,
        backgroundImage: profileImagePath.isNotEmpty
            ? FileImage(File(profileImagePath))
            : const AssetImage('assets/default_profile.png') as ImageProvider,
      ),
    );
  }
}
