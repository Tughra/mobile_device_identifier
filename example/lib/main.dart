import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceId = 'Unknown';
  final _mobileDeviceIdentifierPlugin = MobileDeviceIdentifier();

  @override
  void initState() {
    super.initState();
    initDeviceId();
  }

  Future<void> initDeviceId() async {
    String deviceId;
    try {
      deviceId = await _mobileDeviceIdentifierPlugin.getDeviceId() ??
          'Unknown platform version';
    } on PlatformException {
      deviceId = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _deviceId = deviceId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile device identifier'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Device ID : \n\n$_deviceId',
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
