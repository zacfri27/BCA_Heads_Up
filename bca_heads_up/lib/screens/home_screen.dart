// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'credits_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // scaffold is the basic page template and gives us background, app bar, etc.
    return Scaffold(
      // container lets us apply a background gradient to the whole screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // safeArea pushes content below the phone's notch/status bar
        child: SafeArea(
          // center puts its child in the middle of the screen (like css in Mr. Sen's web page project)
          child: Center(
            // Column stacks widgets vertically (like a vertical list)
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // center vertically
              children: [
                // ── Title area ──────────────────────────────
                ClipRRect(
                  child: Image.asset(
                    'assets/home/title_logo.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12), // SizedBox = invisible spacer

                const Text(
                  'Heads Up!',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                const Text(
                  'The ultimate party guessing game',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 60),

                // ── Menu Buttons ─────────────────────────────
                // Navigator.push() is how you go to a new screen
                // like a stack of cards since push adds one on top
                MenuButton(
                  label: 'Play',
                  icon: Icons.play_arrow_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                MenuButton(
                  label: 'Credits',
                  icon: Icons.info_outline_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreditsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Reusable Button Widget ───────────────────────────────────
// Instead of copying button code 3 times, we made one widget
// that accepts a label, icon, and function as parameters.
class MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap; // VoidCallback = a function that takes no args

  const MenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFFFF6B35),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
