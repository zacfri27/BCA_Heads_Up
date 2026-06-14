// lib/main.dart

import 'package:flutter/material.dart';

// This is always the first function that runs — like main() in Java
void main() {
  runApp(const MyApp());
}

// MyApp is our root widget. Everything else lives inside it.
// StatelessWidget means this widget never changes after it's built.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp sets up the whole app — theme, title, starting screen
    return MaterialApp(
      title: 'Heads Up!',
      debugShowCheckedModeBanner: false, // hides the red 'DEBUG' banner

      // Our color theme — orange feels energetic and fun
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35), // hex color: orange
          brightness: Brightness.dark,        // dark mode base
        ),
        useMaterial3: true,
      ),

      // The first screen the user sees
      home: const HomeScreen(),
    );
  }
}