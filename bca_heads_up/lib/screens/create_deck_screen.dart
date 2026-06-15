import 'package:flutter/material.dart';

import '../models/category.dart';
import '../theme/app_colors.dart';

// this screen lets the user make their own deck
class CreateDeckScreen extends StatefulWidget {
  const CreateDeckScreen({super.key});

  @override
  State<CreateDeckScreen> createState() => _CreateDeckScreenState();
}

class _CreateDeckScreenState extends State<CreateDeckScreen> {
  // controllers let us read what the user typed in the text boxes
  final TextEditingController nameController = TextEditingController();
  final TextEditingController wordsController = TextEditingController();

  @override
  void dispose() {
    // clean these up when we leave the screen
    nameController.dispose();
    wordsController.dispose();
    super.dispose();
  }

  void createDeck() {
    final deckName = nameController.text.trim();

    // split by commas or new lines, so both formats work
    final words = wordsController.text
        .split(RegExp(r'[,\n]'))
        .map((word) => word.trim())
        .where((word) => word.isNotEmpty)
        .toList();

    if (deckName.isEmpty) {
      showMessage('give the deck a name first');
      return;
    }

    if (words.length < 2) {
      showMessage('add at least 2 words');
      return;
    }

    final newDeck = Category(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: deckName,

      // using a plcaeholder image we already have so we dont need new assets yet
      imagePath: 'assets/home/title_logo.png',

      words: words,
    );

    // send the new deck back to the category screen
    Navigator.pop(context, newDeck);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.cardLight),
    );
  }

  InputDecoration inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: AppColors.textSoft),
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: AppColors.card,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.accent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text('Create Deck'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textMain,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Custom Deck',
                style: TextStyle(
                  color: AppColors.textMain,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Type a deck name, then add words separated by commas or new lines.',
                style: TextStyle(color: AppColors.textSoft, fontSize: 16),
              ),

              const SizedBox(height: 24),

              TextField(
                controller: nameController,
                style: const TextStyle(color: AppColors.textMain),
                decoration: inputDecoration('Deck name', 'ex: BCA Memes'),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: wordsController,
                style: const TextStyle(color: AppColors.textMain),
                maxLines: 8,
                decoration: inputDecoration(
                  'Words',
                  'ex: lower cafe, Mr. Sen, chem lab, chick-fil-a',
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: createDeck,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text(
                    'create deck',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.background,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
