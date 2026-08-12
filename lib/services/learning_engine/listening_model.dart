class ListeningLesson {
  final int id;
  final String title;
  final String description;
  final String audioUrl; // Local path for offline
  final String transcript;
  final String? arabicTranscript;
  final String level; // A1, A2, B1, B2, C1, C2
  final int durationSeconds;
  final List<String> vocabulary;
  final List<ListeningQuestion> questions;

  ListeningLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.transcript,
    this.arabicTranscript,
    required this.level,
    required this.durationSeconds,
    this.vocabulary = const [],
    this.questions = const [],
  });
}

class ListeningQuestion {
  final int id;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? explanation;
  final int timeStampSeconds; // When to ask in the audio

  ListeningQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    required this.timeStampSeconds,
  });
}

class ListeningProgress {
  final int lessonId;
  final bool isCompleted;
  final int correctAnswers;
  final int totalQuestions;
  final DateTime? completedDate;

  ListeningProgress({
    required this.lessonId,
    required this.isCompleted,
    required this.correctAnswers,
    required this.totalQuestions,
    this.completedDate,
  });

  double get score => totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;
}
