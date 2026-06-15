// lib/screens/category_screen.dart

import 'package:flutter/material.dart';
import '../models/category.dart'; // the '..' means "go up one folder"
import 'game_screen.dart';
import '../theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Category'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textMain,
      ),
      // GridView is like ListView but shows items in a grid
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 12, // horizontal gap between cards
          mainAxisSpacing: 12, // vertical gap between cards
          childAspectRatio: 1.75, // width/height ratio of each card
        ),
        itemCount: builtInCategories.length,
        itemBuilder: (context, index) {
          final category = builtInCategories[index]; // current category

          // GestureDetector wraps any widget and gives it tap behavior
          return GestureDetector(
            onTap: () {
              // Pass the selected category to the GameScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(category: category),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              // Column to stack emoji on top of text
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      category.imagePath,
                      width: 500,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    category.name,
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 75,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
