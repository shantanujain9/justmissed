import 'package:flutter/material.dart';
import 'package:justmissed/screens/registration_page.dart';
import 'package:justmissed/screens/homepage.dart';

void main() {
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
  final TextEditingController passwordController = TextEditingController();

  bool isLoginButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Add listeners to the text controllers
    usernameController.addListener(validateInputs);
    passwordController.addListener(validateInputs);
  }

  @override
  void dispose() {
    // Clean up the controllers when they are no longer needed
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateInputs() {
    final username = usernameController.text;
    final password = passwordController.text;

    // Check if both username and password are not empty
    setState(() {
      isLoginButtonEnabled = username.isNotEmpty && password.isNotEmpty;
    });
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
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: isLoginButtonEnabled
                      ? () {
                          // Handle login logic here
                          bool isAuthenticated = true;
                          if (isAuthenticated) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        }
                      : null, // Disable the button if inputs are empty
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
