import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  Position? _currentPosition;
  Stream<QuerySnapshot>? _userStream;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _initializeFirestore();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _initializeFirestore() {
    // Initialize Firestore
    _userStream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Users'),
      ),
      body: _currentPosition == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _userStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                }

                List<Widget> nearbyUsersWidgets = [];

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];

                    // Check if the document exists
                    if (doc.exists) {
                      // Verify that the required fields exist
                      double? userLatitude = doc['latitude'] as double?;
                      double? userLongitude = doc['longitude'] as double?;
                      String? displayName = doc['displayName'] as String?;

                      // Check if the required fields have valid values
                      if (userLatitude != null &&
                          userLongitude != null &&
                          displayName != null) {
                        double distance = Geolocator.distanceBetween(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                          userLatitude,
                          userLongitude,
                        );

                        if (distance < 5000) {
                          // Add the user's profile to the list of nearby users
                          nearbyUsersWidgets.add(
                            ListTile(
                              title: Text(displayName),
                              subtitle: Text(
                                  'Distance: ${distance.toStringAsFixed(2)} meters'),
                              onTap: () {
                                // Navigate to the user's profile or chat screen when tapped
                                // You can pass the user's ID or other information to the profile/chat screen
                              },
                            ),
                          );
                        }
                      }
                    }

                    return SizedBox
                        .shrink(); // Empty SizedBox if the document or required fields don't exist
                  },
                );
              },
            ),
    );
  }
}
