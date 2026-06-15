  class Category {
  final String id;
  final String name;
  final String imagePath; //replaces original emoji with where images are stored
  
  final List<String> words;
  // Constructor just like java

  const Category({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.words,
  });
}

final List<Category> builtInCategories = [
  Category(
    id: 'classes',
    name: 'Classes',
    imagePath: 'assets/categories/BCA_classes.png',
    words: [
      'Calc/Math',
      'English',
      'AP Comp Sci',
      'Chem',
      'Physics',
      'Online Health',
      'Gym/PE',
      'Spanish',
      'Mandarin',
      'French',
      'History',
      //add more classes here
    ],
  ),
  Category(
    id: 'teachers',
    name: 'Teachers',
    imagePath: 'assets/categories/BCA_teachers.png',
    words: [
      'Mr. Isecke',
      'Mr. Sen',
      'Mr. Respass',
      'Dr. Carter',
      'Dr. Abramson',
      'Profe Seltzer',
      'Profe Lewitt',
      'Mrs. Dr. Crane',
      'Mr. Dr. Crane',
      'Profe Calandra',
      'Profe Torres-Perez',
      'Mr. Russo',
      'Dr. Zubov',
      //we will have to add more teachers here lol
    ],
  ),
  Category(
    id: 'students',
    name: 'Students',
    imagePath: 'assets/categories/BCA_students.png',
    words: [
      'Zack Friedman',
      'Ewan Kim',
      'Danny Paik',
      'Aalok Pathak',
      'Skanda Ramanathan',
      'Soham Kaushal',
      'Joshua Lee',
      //add more students here too
    ],
  ),
  // More categories can be added, as well as more values in each category in the future
];