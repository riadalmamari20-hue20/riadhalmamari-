class Antonym {
  final int id;
  final int wordId;
  final String antonymWord;
  final String? definition;

  Antonym({
    required this.id,
    required this.wordId,
    required this.antonymWord,
    this.definition,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wordId': wordId,
      'antonymWord': antonymWord,
      'definition': definition,
    };
  }

  factory Antonym.fromMap(Map<String, dynamic> map) {
    return Antonym(
      id: map['id'] as int,
      wordId: map['wordId'] as int,
      antonymWord: map['antonymWord'] as String,
      definition: map['definition'] as String?,
    );
  }
}
