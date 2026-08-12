class Synonym {
  final int id;
  final int wordId;
  final String synonymWord;
  final String? definition;

  Synonym({
    required this.id,
    required this.wordId,
    required this.synonymWord,
    this.definition,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wordId': wordId,
      'synonymWord': synonymWord,
      'definition': definition,
    };
  }

  factory Synonym.fromMap(Map<String, dynamic> map) {
    return Synonym(
      id: map['id'] as int,
      wordId: map['wordId'] as int,
      synonymWord: map['synonymWord'] as String,
      definition: map['definition'] as String?,
    );
  }
}
