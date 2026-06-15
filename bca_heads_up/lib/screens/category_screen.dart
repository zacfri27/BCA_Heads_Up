// lib/screens/category_screen.dart

import 'package:flutter/material.dart';
import '../models/category.dart'; // the '..' means "go up one folder"
import 'game_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Category'),
        backgroundColor: const Color(0xFFFF6B35),
        foregroundColor: Colors.white,
      ),
      // GridView is like ListView but shows items in a grid
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 12, // horizontal gap between cards
          mainAxisSpacing: 12, // vertical gap between cards
          childAspectRatio: 1.1, // width/height ratio of each card
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
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              // Column to stack emoji on top of text
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      category.imagePath,
                      width: 60, //change for larger images
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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
