class Word {
  final int id;
  final String englishWord;
  final String arabicMeaning;
  final String? ipa;
  final String? usaPronunciation;
  final String? ukPronunciation;
  final String? partOfSpeech;
  final String? cefr; // A1, A2, B1, B2, C1, C2
  final String? definition;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int frequency; // How often the word appears
  final bool isFavorite;

  Word({
    required this.id,
    required this.englishWord,
    required this.arabicMeaning,
    this.ipa,
    this.usaPronunciation,
    this.ukPronunciation,
    this.partOfSpeech,
    this.cefr,
    this.definition,
    required this.createdAt,
    this.updatedAt,
    this.frequency = 0,
    this.isFavorite = false,
  });

  Word copyWith({
    int? id,
    String? englishWord,
    String? arabicMeaning,
    String? ipa,
    String? usaPronunciation,
    String? ukPronunciation,
    String? partOfSpeech,
    String? cefr,
    String? definition,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? frequency,
    bool? isFavorite,
  }) {
    return Word(
      id: id ?? this.id,
      englishWord: englishWord ?? this.englishWord,
      arabicMeaning: arabicMeaning ?? this.arabicMeaning,
      ipa: ipa ?? this.ipa,
      usaPronunciation: usaPronunciation ?? this.usaPronunciation,
      ukPronunciation: ukPronunciation ?? this.ukPronunciation,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      cefr: cefr ?? this.cefr,
      definition: definition ?? this.definition,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      frequency: frequency ?? this.frequency,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'englishWord': englishWord,
      'arabicMeaning': arabicMeaning,
      'ipa': ipa,
      'usaPronunciation': usaPronunciation,
      'ukPronunciation': ukPronunciation,
      'partOfSpeech': partOfSpeech,
      'cefr': cefr,
      'definition': definition,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'frequency': frequency,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'] as int,
      englishWord: map['englishWord'] as String,
      arabicMeaning: map['arabicMeaning'] as String,
      ipa: map['ipa'] as String?,
      usaPronunciation: map['usaPronunciation'] as String?,
      ukPronunciation: map['ukPronunciation'] as String?,
      partOfSpeech: map['partOfSpeech'] as String?,
      cefr: map['cefr'] as String?,
      definition: map['definition'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt'] as String) : null,
      frequency: map['frequency'] as int? ?? 0,
      isFavorite: (map['isFavorite'] as int? ?? 0) == 1,
    );
  }
}
