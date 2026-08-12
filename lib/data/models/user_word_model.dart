class UserWord {
  final int id;
  final int wordId;
  final DateTime dateAdded;
  final int timesReviewed;
  final int correctAnswers;
  final int incorrectAnswers;
  final String status; // NEW, LEARNING, REVIEW, MASTERED
  final DateTime? lastReviewDate;
  final DateTime? nextReviewDate;
  final int ease; // SM2 algorithm ease factor (1000 = 1.0)
  final int interval; // Days until next review
  final int repetitions; // Number of times reviewed
  final int lapses; // Number of times forgotten

  UserWord({
    required this.id,
    required this.wordId,
    required this.dateAdded,
    this.timesReviewed = 0,
    this.correctAnswers = 0,
    this.incorrectAnswers = 0,
    this.status = 'NEW',
    this.lastReviewDate,
    this.nextReviewDate,
    this.ease = 2500,
    this.interval = 1,
    this.repetitions = 0,
    this.lapses = 0,
  });

  UserWord copyWith({
    int? id,
    int? wordId,
    DateTime? dateAdded,
    int? timesReviewed,
    int? correctAnswers,
    int? incorrectAnswers,
    String? status,
    DateTime? lastReviewDate,
    DateTime? nextReviewDate,
    int? ease,
    int? interval,
    int? repetitions,
    int? lapses,
  }) {
    return UserWord(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      dateAdded: dateAdded ?? this.dateAdded,
      timesReviewed: timesReviewed ?? this.timesReviewed,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
      status: status ?? this.status,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      ease: ease ?? this.ease,
      interval: interval ?? this.interval,
      repetitions: repetitions ?? this.repetitions,
      lapses: lapses ?? this.lapses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wordId': wordId,
      'dateAdded': dateAdded.toIso8601String(),
      'timesReviewed': timesReviewed,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'status': status,
      'lastReviewDate': lastReviewDate?.toIso8601String(),
      'nextReviewDate': nextReviewDate?.toIso8601String(),
      'ease': ease,
      'interval': interval,
      'repetitions': repetitions,
      'lapses': lapses,
    };
  }

  factory UserWord.fromMap(Map<String, dynamic> map) {
    return UserWord(
      id: map['id'] as int,
      wordId: map['wordId'] as int,
      dateAdded: DateTime.parse(map['dateAdded'] as String),
      timesReviewed: map['timesReviewed'] as int? ?? 0,
      correctAnswers: map['correctAnswers'] as int? ?? 0,
      incorrectAnswers: map['incorrectAnswers'] as int? ?? 0,
      status: map['status'] as String? ?? 'NEW',
      lastReviewDate: map['lastReviewDate'] != null ? DateTime.parse(map['lastReviewDate'] as String) : null,
      nextReviewDate: map['nextReviewDate'] != null ? DateTime.parse(map['nextReviewDate'] as String) : null,
      ease: map['ease'] as int? ?? 2500,
      interval: map['interval'] as int? ?? 1,
      repetitions: map['repetitions'] as int? ?? 0,
      lapses: map['lapses'] as int? ?? 0,
    );
  }
}
