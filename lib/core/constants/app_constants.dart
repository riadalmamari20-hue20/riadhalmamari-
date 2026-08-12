class AppConstants {
  // App info
  static const String appName = 'English Pocket Teacher';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String databaseName = 'english_pocket_teacher.db';
  static const int databaseVersion = 1;
  
  // Spaced Repetition
  static const int initialEase = 250;
  static const int initialInterval = 1;
  static const double easyBonus = 1.3;
  static const double hardPenalty = 0.6;
  static const int lapseThreshold = 30;
  
  // XP
  static const int xpPerNewWord = 10;
  static const int xpPerCorrectAnswer = 5;
  static const int xpPerReview = 2;
  static const int xpPerLessonCompletion = 50;
  
  // Levels
  static const List<int> levelXpThresholds = [
    0,      // Level 1
    100,    // Level 2
    300,    // Level 3
    600,    // Level 4
    1000,   // Level 5
    1500,   // Level 6
    2100,   // Level 7
    2800,   // Level 8
    3600,   // Level 9
    4500,   // Level 10
  ];
}
