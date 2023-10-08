import 'package:flutter/material.dart';
import 'package:justmissed/screens/confirm_Request.dart';
import 'package:justmissed/screens/homepage.dart';

class AcceptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accept Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the Accept Page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the HomePage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmRequest(),
                  ),
                );
              },
              child: Text('Go to HomePage'),
            ),
          ],
        ),
      ),
    );
  }
}
