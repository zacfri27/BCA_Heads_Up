// lib/screens/game_screen.dart

// need this for Timer
import 'dart:async';

// normal flutter widgets
import 'package:flutter/material.dart';

// this lets us use the Category class we made
import '../models/category.dart';

// this screen has changing stuff like time, score, and words
// so it has to be StatefulWidget, not StatelessWidget
class GameScreen extends StatefulWidget {
  // this stores the category that the user picked
  final Category category;

  const GameScreen({
    super.key,
    required this.category,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

// this is where the changing variables go
class _GameScreenState extends State<GameScreen> {
  // late means "i will set this before i actually use it"
  late List<String> words;

  // which word in the list we are currently on
  int currentIndex = 0;

  // round timer
  int timeLeft = 60;

  // score numbers
  int score = 0;
  int passed = 0;

  // the timer object, starts as nothing
  Timer? timer;

  // this stops the game from ending twice by accident
  bool roundEnded = false;

  @override
  void initState() {
    super.initState();

    // widget.category is how this State class gets the category
    // from the GameScreen widget above
    words = List<String>.from(widget.category.words);

    // mix up the words so it is not the same order every time
    words.shuffle();

    // start counting down right away
    startTimer();
  }

  void startTimer() {
    // runs this code every 1 second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft <= 1) {
        endGame();
      } else {
        // setState means "change this and redraw the screen"
        setState(() {
          timeLeft--;
        });
      }
    });
  }

  void markCorrect() {
    // user got the word right
    setState(() {
      score++;
      goToNextWord();
    });
  }

  void markPassed() {
    // user skipped the word
    setState(() {
      passed++;
      goToNextWord();
    });
  }

  void goToNextWord() {
    // if there are more words, move forward
    if (currentIndex < words.length - 1) {
      currentIndex++;
    } else {
      // if there are no more words, end the round
      endGame();
    }
  }

  void endGame() {
    // if this already ran, dont run it again
    if (roundEnded) return;

    roundEnded = true;

    // stop the timer
    timer?.cancel();

    // make sure the screen still exists before showing popup
    if (!mounted) return;

    // simple popup for now
    // later we can replace this with a real results screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Round Over!'),
          content: Text(
            'Score: $score correct\nPassed: $passed',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // closes popup
                Navigator.pop(context); // goes back to category screen
              },
              child: const Text('Back to Categories'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // if we leave this screen, stop the timer
    // otherwise it can keep running in the background
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // get the current word
    final currentWord = words[currentIndex];

    return Scaffold(
      body: Container(
        // background color gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFFD7263D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              // top row with category and timer
              Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.category.emoji} ${widget.category.name}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    Text(
                      '${timeLeft}s',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // big word in the middle
              Text(
                currentWord,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              // current score
              Text(
                '✅ $score correct   ⏭ $passed passed',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 16),

              // temporary buttons
              // later these can be replaced with tilt controls
              Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: markPassed,
                        child: const Text('Pass'),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: markCorrect,
                        child: const Text('Got it!'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}