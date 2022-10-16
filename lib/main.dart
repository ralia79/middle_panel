import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:screen/screen.dart';
import 'package:vikav/views/homeScreen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);

  Screen.keepOn(true);
  getPer();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

Future<void> getPer() async {
  Permission.microphone.request();
  Permission.camera.request();
}
