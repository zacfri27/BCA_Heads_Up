// lib/screens/credits_screen.dart

// this gives us flutter stuff like Scaffold, Text, AppBar, etc
import 'package:flutter/material.dart';

// this is just the credits page
// it does not really change, so stateless is fine
class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is like the basic page layout for flutter
    return Scaffold(
      // top bar of the screen
      appBar: AppBar(
        title: const Text('Credits'),
        backgroundColor: const Color(0xFFFF6B35),
        foregroundColor: Colors.white,
      ),

      // main stuff on the page
      body: const Padding(
        // adds space so text isnt on the edge
        padding: EdgeInsets.all(24),

        // column stacks stuff up and down
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Heads Up! Clone',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            Text(
              'Built with Flutter and Dart.\n\n'
              'This is my student version of a Heads Up style game.\n\n'
              'Current features:\n'
              '• home menu\n'
              '• category selection\n'
              '• word guessing screen\n'
              '• timer\n'
              '• score tracking',
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}