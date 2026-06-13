class Category {
  final String name;
  final List<String> words;
  // Constructor just like java
  const Category({
    required this.name,
    required this.words,
  });
}
final List<Category> builtInCategories = [
    Category(
      name: 'Teachers',
      words: ['Mr. Isecke', 'Mr. Sen', 'Dr. Carter', 'Mr. Wertz', 'Mr.Respass'],
    ),

    Category(
      name: 'Juniors',
      words: ['Zack F', 'Ewan K', "Danny P", "Aalok P", "Soham K"],
    ),
    // More categories can be added, as well as more values in each category in the future
  ];