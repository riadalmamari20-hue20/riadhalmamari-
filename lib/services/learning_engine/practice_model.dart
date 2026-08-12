import 'package:english_pocket_teacher/services/learning_engine/spaced_repetition_engine.dart';

class PracticeQuestion {
  final int id;
  final int wordId;
  final String englishWord;
  final String type; // multiple_choice, fill_blank, synonym, antonym, listening, etc
  final String question;
  final String correctAnswer;
  final List<String> options;
  final String? arabicContext;
  final DateTime createdAt;

  PracticeQuestion({
    required this.id,
    required this.wordId,
    required this.englishWord,
    required this.type,
    required this.question,
    required this.correctAnswer,
    required this.options,
    this.arabicContext,
    required this.createdAt,
  });
}

class PracticeSession {
  final int id;
  final DateTime startTime;
  DateTime? endTime;
  final List<PracticeQuestionResult> results;
  final String sessionType; // daily, review, lesson, etc

  PracticeSession({
    required this.id,
    required this.startTime,
    this.endTime,
    this.results = const [],
    this.sessionType = 'daily',
  });

  int get totalQuestions => results.length;
  int get correctAnswers => results.where((r) => r.isCorrect).length;
  double get accuracy => totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;
  Duration? get duration => endTime != null ? endTime!.difference(startTime) : null;
}

class PracticeQuestionResult {
  final int questionId;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final DateTime answeredAt;

  PracticeQuestionResult({
    required this.questionId,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.answeredAt,
  });
}
