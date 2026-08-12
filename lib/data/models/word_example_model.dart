class WordExample {
  final int id;
  final int wordId;
  final String example;
  final String? arabicTranslation;
  final DateTime createdAt;

  WordExample({
    required this.id,
    required this.wordId,
    required this.example,
    this.arabicTranslation,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wordId': wordId,
      'example': example,
      'arabicTranslation': arabicTranslation,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory WordExample.fromMap(Map<String, dynamic> map) {
    return WordExample(
      id: map['id'] as int,
      wordId: map['wordId'] as int,
      example: map['example'] as String,
      arabicTranslation: map['arabicTranslation'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}
