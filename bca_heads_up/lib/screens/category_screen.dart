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
  // how long each round lasts
  int roundSeconds = 60;

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
          PopupMenuButton<int>(
            tooltip: 'Timer Length',
            initialValue: roundSeconds,
            onSelected: (value) {
              setState(() {
                roundSeconds = value;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 30, child: Text('30 seconds')),
              PopupMenuItem(value: 60, child: Text('60 seconds')),
              PopupMenuItem(value: 90, child: Text('90 seconds')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Text(
                  '${roundSeconds}s',
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
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
        itemCount: allCategories.length + 1,

        itemBuilder: (context, index) {
          // first card is for making a custom deck
          if (index == 0) {
            return GestureDetector(
              onTap: openCreateDeckScreen,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_circle_rounded,
                      color: AppColors.background,
                      size: 54,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Create Deck',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fredoka(
                        color: AppColors.background,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'make your own words',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // subtract 1 because index 0 is the create deck card
          final category = allCategories[index - 1]; // current category

          // GestureDetector wraps any widget and gives it tap behavior
          return GestureDetector(
            onTap: () {
              // pass the selected category to the GameScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(
                    category: category,
                    roundSeconds: roundSeconds,
                  ),
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
