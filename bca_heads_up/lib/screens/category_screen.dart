import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/category.dart'; // the '..' means "go up one folder"
import '../theme/app_colors.dart';
import 'create_deck_screen.dart';
import 'game_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<void> openCreateDeckScreen() async {
    // open the create deck page and wait for it to send a deck back
    final newDeck = await Navigator.push<Category>(
      context,
      MaterialPageRoute(builder: (context) => const CreateDeckScreen()),
    );

    // if the user made a deck, add it and redraw the grid
    if (newDeck != null) {
      setState(() {
        customCategories.add(newDeck);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // show both the built in decks and the user made decks
    final allCategories = [...builtInCategories, ...customCategories];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Category'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textMain,
        actions: [
          // small plus button so the screen still keeps the same layout
          IconButton(
            onPressed: openCreateDeckScreen,
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Create Deck',
          ),
        ],
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
        itemCount: allCategories.length,

        itemBuilder: (context, index) {
          final category = allCategories[index]; // current category

          // GestureDetector wraps any widget and gives it tap behavior
          return GestureDetector(
            onTap: () {
              // pass the selected category to the GameScreen
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

              // Column to stack image on top of text
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
                    textAlign: TextAlign.center,
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
