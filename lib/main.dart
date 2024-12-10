// main.dart

// Entry point of the Flutter application.
// The material.dart package is imported for building Flutter UI components like MaterialApp, Scaffold, and widgets.
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
      MyApp()); // Initializes the widget tree and launches the app starting from the provided root widget.
}

// Main application widget that sets up basic configuration.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Example', // Title of the application.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary theme color.
      ),
      home: LoginScreen(), // Initial screen shown to the user.
    );
  }
}
