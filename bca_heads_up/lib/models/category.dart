  class Category {
  final String id;
  final String name;
  final String emoji;
  final List<String> words;
  // Constructor just like java

  const Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.words,
  });
}

final List<Category> builtInCategories = [
  Category(
    id: 'animals',
    name: 'Animals',
    emoji: '🐘',
    words: [
      'Elephant',
      'Penguin',
      'Giraffe',
      'Dolphin',
      'Kangaroo',
      'Cheetah',
      'Flamingo',
      'Octopus',
    ],
  ),
  Category(
    id: 'movies',
    name: 'Movies',
    emoji: '🎬',
    words: [
      'Titanic',
      'Inception',
      'The Lion King',
      'Jurassic Park',
      'Toy Story',
      'The Matrix',
    ],
  ),
  Category(
    id: 'celebrities',
    name: 'Celebrities',
    emoji: '⭐',
    words: [
      'Taylor Swift',
      'Beyoncé',
      'LeBron James',
      'Tom Hanks',
      'Rihanna',
      'Dwayne Johnson',
    ],
  ),
  Category(
    id: 'actions',
    name: 'Act It Out',
    emoji: '🎭',
    words: [
      'Swimming',
      'Juggling',
      'Surfing',
      'Playing Guitar',
      'Baking a Cake',
      'Rock Climbing',
    ],
  ),
  // More categories can be added, as well as more values in each category in the future
];