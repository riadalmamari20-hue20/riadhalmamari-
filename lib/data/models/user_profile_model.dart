class UserProfile {
  final int id;
  final int totalXP;
  final int level;
  final int currentStreak;
  final int bestStreak;
  final DateTime lastActivityDate;
  final DateTime createdAt;
  final int wordsLearned;
  final int reviewsDone;

  UserProfile({
    required this.id,
    this.totalXP = 0,
    this.level = 1,
    this.currentStreak = 0,
    this.bestStreak = 0,
    required this.lastActivityDate,
    required this.createdAt,
    this.wordsLearned = 0,
    this.reviewsDone = 0,
  });

  UserProfile copyWith({
    int? id,
    int? totalXP,
    int? level,
    int? currentStreak,
    int? bestStreak,
    DateTime? lastActivityDate,
    DateTime? createdAt,
    int? wordsLearned,
    int? reviewsDone,
  }) {
    return UserProfile(
      id: id ?? this.id,
      totalXP: totalXP ?? this.totalXP,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      createdAt: createdAt ?? this.createdAt,
      wordsLearned: wordsLearned ?? this.wordsLearned,
      reviewsDone: reviewsDone ?? this.reviewsDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalXP': totalXP,
      'level': level,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
      'lastActivityDate': lastActivityDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'wordsLearned': wordsLearned,
      'reviewsDone': reviewsDone,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as int,
      totalXP: map['totalXP'] as int? ?? 0,
      level: map['level'] as int? ?? 1,
      currentStreak: map['currentStreak'] as int? ?? 0,
      bestStreak: map['bestStreak'] as int? ?? 0,
      lastActivityDate: DateTime.parse(map['lastActivityDate'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      wordsLearned: map['wordsLearned'] as int? ?? 0,
      reviewsDone: map['reviewsDone'] as int? ?? 0,
    );
  }
}
