class GrammarLesson {
  final int id;
  final String title;
  final String description;
  final String content; // HTML or Markdown
  final String level; // A1, A2, B1, B2, C1, C2
  final String category; // Tense, Modal, etc
  final List<String> examples;
  final List<GrammarRule> rules;
  final List<GrammarExercise> exercises;

  GrammarLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.level,
    required this.category,
    this.examples = const [],
    this.rules = const [],
    this.exercises = const [],
  });
}

class GrammarRule {
  final String title;
  final String explanation;
  final List<String> examples;
  final List<String> exceptions;

  GrammarRule({
    required this.title,
    required this.explanation,
    this.examples = const [],
    this.exceptions = const [],
  });
}

class GrammarExercise {
  final int id;
  final String question;
  final String correctAnswer;
  final List<String> options;
  final String explanation;
  final String relatedRule;

  GrammarExercise({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.options,
    required this.explanation,
    required this.relatedRule,
  });
}

class GrammarProgress {
  final int lessonId;
  final int correctAnswers;
  final int totalAttempts;
  final DateTime lastAttemptDate;
  final bool isCompleted;

  GrammarProgress({
    required this.lessonId,
    required this.correctAnswers,
    required this.totalAttempts,
    required this.lastAttemptDate,
    required this.isCompleted,
  });

  double get score => totalAttempts > 0 ? (correctAnswers / totalAttempts) * 100 : 0;
}
