// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'credits_screen.dart';
import '../theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // scaffold is the basic page template and gives us background, app bar, etc.
    return Scaffold(
      // container lets us apply a background color for the whole screen
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
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
                    width: 500,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12), // SizedBox = invisible spacer

                const Text(
                  'BCA Heads Up!',
                  style: TextStyle(
                    fontSize: 90,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),

                Text(
                  'The party guessing game for lower cafe dwellers',
                  style: GoogleFonts.luckiestGuy(
                    fontSize: 22,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 60),

                // ── Menu Buttons ─────────────────────────────
                // Navigator.push() is how you go to a new screen
                // like a stack of cards since push adds one on top
                MenuButton(
                  label: 'Play',
                  icon: Icons.play_arrow_rounded,
                  width: 320,
                  backgroundColor: AppColors.accent,
                  textColor: AppColors.background,
                  verticalPadding: 22,
                  fontSize: 24,
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
  final VoidCallback onTap;

  // optional style stuff so the play button can be bigger
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final double verticalPadding;
  final double fontSize;

  const MenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.width = 250,
    this.backgroundColor = AppColors.card,
    this.textColor = AppColors.accent,
    this.verticalPadding = 14,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: fontSize + 4),
        label: Text(
          label,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          elevation: 6,
          shadowColor: backgroundColor.withOpacity(0.45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
