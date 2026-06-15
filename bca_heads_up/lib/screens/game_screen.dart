// need this for Timer
import 'dart:async';

// normal flutter widgets
import 'package:flutter/material.dart';

// this lets us use the Category class we made
import '../models/category.dart';

//lets us use universal colors
import '../theme/app_colors.dart';

//lets us use fonts
import 'package:google_fonts/google_fonts.dart';

// this screen has changing stuff like time, score, and words
// so it has to be StatefulWidget, not StatelessWidget
class GameScreen extends StatefulWidget {
  // this stores the category that the user picked
  final Category category;

  // how long the round should be
  final int roundSeconds;

  const GameScreen({super.key, required this.category, this.roundSeconds = 60});

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
  late int timeLeft;

  // score numbers
  int score = 0;
  int passed = 0;

  // the timer object, starts as nothing
  Timer? timer;

  // this stops the game from ending twice by accident
  bool roundEnded = false;

  @override
  @override
  void initState() {
    super.initState();

    // use the timer length that got picked on the category screen
    timeLeft = widget.roundSeconds;

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
      if (roundEnded) return;

      if (timeLeft <= 1) {
        // make it show 0 before ending
        setState(() {
          timeLeft = 0;
        });

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
    // dont let buttons work after the round ended
    if (roundEnded) return;

    // user got the word right
    setState(() {
      score++;
    });

    goToNextWord();
  }

  void markPassed() {
    // dont let buttons work after the round ended
    if (roundEnded) return;

    // user skipped the word
    setState(() {
      passed++;
    });

    goToNextWord();
  }

  void goToNextWord() {
    // if there are more words, move forward
    if (currentIndex < words.length - 1) {
      setState(() {
        currentIndex++;
      });
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
          backgroundColor: AppColors.card,
          title: const Text(
            'Round Over!',
            style: TextStyle(
              color: AppColors.textMain,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Score: $score correct\nPassed: $passed',
            style: const TextStyle(color: AppColors.textSoft, fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // closes popup
                Navigator.pop(context); // goes back to category screen
              },
              child: const Text(
                'Back to Categories',
                style: TextStyle(color: AppColors.accent),
              ),
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

    // make timer red near the end
    final timerColor = timeLeft <= 10 ? Colors.redAccent : Colors.white;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.background),

        child: SafeArea(
          child: Column(
            children: [
              // top row with category and timer
              Padding(
                padding: const EdgeInsets.all(16),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // left side of the top bar: image + category name
                    Row(
                      children: [
                        // ClipRRect is what gives the image rounded corners
                        // Image.asset by itself cant do borderRadius
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            widget.category.imagePath,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          widget.category.name,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      '${timeLeft}s',
                      style: TextStyle(
                        color: timerColor,
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
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              // current score
              Text(
                '✅ $score correct   ⏭ $passed passed',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardLight,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'skip',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: markCorrect,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.background,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'got it',
                          style: TextStyle(fontSize: 16),
                        ),
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
