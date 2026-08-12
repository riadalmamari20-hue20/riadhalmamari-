import 'dart:math';
import 'package:english_pocket_teacher/data/models/word_model.dart';
import 'package:english_pocket_teacher/services/learning_engine/practice_model.dart';

class QuestionGenerator {
  /// Generate multiple choice question
  static PracticeQuestion generateMultipleChoice(
    Word correctWord,
    List<Word> allWords, {
    String type = 'english_to_arabic',
  }) {
    final random = Random();
    
    // Get 3 random distractor words
    final shuffled = List<Word>.from(allWords)..shuffle();
    final distractors = shuffled
        .where((w) => w.id != correctWord.id)
        .take(3)
        .toList();

    List<String> options = [];
    
    if (type == 'english_to_arabic') {
      options = [
        correctWord.arabicMeaning,
        ...distractors.map((w) => w.arabicMeaning),
      ];
    } else if (type == 'arabic_to_english') {
      options = [
        correctWord.englishWord,
        ...distractors.map((w) => w.englishWord),
      ];
    }
    
    options.shuffle();

    return PracticeQuestion(
      id: random.nextInt(100000),
      wordId: correctWord.id,
      englishWord: correctWord.englishWord,
      type: 'multiple_choice',
      question: type == 'english_to_arabic'
          ? 'What does "${correctWord.englishWord}" mean in Arabic?'
          : 'Which word means "${correctWord.arabicMeaning}"?',
      correctAnswer: type == 'english_to_arabic'
          ? correctWord.arabicMeaning
          : correctWord.englishWord,
      options: options,
      createdAt: DateTime.now(),
    );
  }

  /// Generate synonym question
  static PracticeQuestion generateSynonymQuestion(
    Word word,
    String? synonym, {
    String otherWord1 = 'happy',
    String otherWord2 = 'sad',
  }) {
    final options = [synonym ?? 'similar word', otherWord1, otherWord2].shuffle();

    return PracticeQuestion(
      id: Random().nextInt(100000),
      wordId: word.id,
      englishWord: word.englishWord,
      type: 'synonym',
      question: 'Which word is a synonym of "${word.englishWord}"?',
      correctAnswer: synonym ?? 'similar word',
      options: options,
      createdAt: DateTime.now(),
    );
  }

  /// Generate fill in the blank question
  static PracticeQuestion generateFillInBlank(
    Word word,
    String sentence, {
    List<String> distractors = const [],
  }) {
    final options = [word.englishWord, ...distractors].toList();
    options.shuffle();

    return PracticeQuestion(
      id: Random().nextInt(100000),
      wordId: word.id,
      englishWord: word.englishWord,
      type: 'fill_blank',
      question: sentence.replaceAll(word.englishWord, '_____'),
      correctAnswer: word.englishWord,
      options: options,
      createdAt: DateTime.now(),
    );
  }

  /// Generate definition matching question
  static PracticeQuestion generateDefinitionMatch(
    Word word,
  ) {
    return PracticeQuestion(
      id: Random().nextInt(100000),
      wordId: word.id,
      englishWord: word.englishWord,
      type: 'definition',
      question: 'What is the definition of "${word.englishWord}"?',
      correctAnswer: word.definition ?? 'No definition available',
      options: [
        word.definition ?? 'No definition',
        'Not the correct definition 1',
        'Not the correct definition 2',
      ].shuffle(),
      createdAt: DateTime.now(),
    );
  }
}
