import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:firebase_core/firebase_core.dart';
import 'package:justmissed/screens/registration_page.dart';
import 'package:justmissed/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();

  bool isLoginButtonEnabled = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // Add a listener to the text controller
    usernameController.addListener(validateInputs);
  }

  @override
  void dispose() {
    // Clean up the controller when it is no longer needed
    usernameController.dispose();
    super.dispose();
  }

  void validateInputs() {
    final username = usernameController.text;

    // Check if the username is not empty
    setState(() {
      isLoginButtonEnabled = username.isNotEmpty;
    });
  }

  Future<void> signInWithUsername() async {
    try {
      final username = usernameController.text;

      // Fetch the user document by username
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (userDoc.docs.isNotEmpty) {
        // Username exists, allow the user to sign in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(username), // Pass the username to the HomePage
          ),
        );
      } else {
        // User with the provided username doesn't exist, show an error message
        print('User not found');
      }
    } catch (e) {
      print('Error signing in: $e');
      // Handle sign-in errors here (e.g., show an error message)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/screens/JustMissedLogo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20.0),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: isLoginButtonEnabled
                      ? () {
                          signInWithUsername();
                        }
                      : null, // Disable the button if the username is empty
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  },
                  child: Text("Registration Page"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
