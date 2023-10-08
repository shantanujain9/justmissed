import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothPage(),
    );
  }
}

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();
    _startScanning();
  }

  Future<void> _startScanning() async {
    try {
      await flutterBlue.startScan(timeout: Duration(seconds: 5));
      flutterBlue.scanResults.listen((results) {
        for (ScanResult result in results) {
          // Connect to the first discovered device (you can choose a specific one)
          if (connectedDevice == null) {
            result.device.connect();
            setState(() {
              connectedDevice = result.device;
            });
          }
        }
      });
    } catch (e) {
      print('Error starting BLE scan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Communication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (connectedDevice != null)
              Text('Connected to: ${connectedDevice!.name}'),
            ElevatedButton(
              onPressed: () {
                // Send data to the connected device
                if (connectedDevice != null) {
                  // Use connectedDevice to send data
                }
              },
              child: Text('Send Data'),
            ),
          ],
        ),
      ),
    );
  }
}
