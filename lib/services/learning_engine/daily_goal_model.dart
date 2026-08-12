class DailyGoal {
  final int targetXP;
  final int currentXP;
  final int wordsToLearn;
  final int wordsLearned;
  final int reviewsToComplete;
  final int reviewsCompleted;

  DailyGoal({
    required this.targetXP,
    required this.currentXP,
    required this.wordsToLearn,
    required this.wordsLearned,
    required this.reviewsToComplete,
    required this.reviewsCompleted,
  });

  double get xpProgress => currentXP / targetXP;
  double get wordsProgress => wordsLearned / wordsToLearn;
  double get reviewsProgress => reviewsCompleted / reviewsToComplete;

  bool get isXPCompleted => currentXP >= targetXP;
  bool get isWordsCompleted => wordsLearned >= wordsToLearn;
  bool get isReviewsCompleted => reviewsCompleted >= reviewsToComplete;
  bool get isDayCompleted => isXPCompleted && isWordsCompleted && isReviewsCompleted;
}
