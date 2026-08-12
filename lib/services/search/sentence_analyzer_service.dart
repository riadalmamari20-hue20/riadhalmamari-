import 'package:english_pocket_teacher/data/repositories/word_repository.dart';
import 'package:english_pocket_teacher/data/models/word_model.dart';

class SentenceAnalyzerService {
  final WordRepository _wordRepository;

  SentenceAnalyzerService(this._wordRepository);

  /// Analyze a sentence word by word
  Future<AnalyzedSentence> analyzeSentence(String sentence) async {
    final words = sentence.split(' ');
    final analyzedWords = <AnalyzedWord>[];

    for (final word in words) {
      final cleanWord = word.replaceAll(RegExp(r'[.,!?;:"]'), '').toLowerCase();
      
      if (cleanWord.isEmpty) continue;

      try {
        final wordData = await _wordRepository.getWordByEnglish(cleanWord);
        if (wordData != null) {
          analyzedWords.add(
            AnalyzedWord(
              word: word,
              cleanWord: cleanWord,
              meaning: wordData.arabicMeaning,
              partOfSpeech: wordData.partOfSpeech,
              definition: wordData.definition,
              ipa: wordData.ipa,
              isFound: true,
            ),
          );
        } else {
          analyzedWords.add(
            AnalyzedWord(
              word: word,
              cleanWord: cleanWord,
              isFound: false,
            ),
          );
        }
      } catch (e) {
        analyzedWords.add(
          AnalyzedWord(
            word: word,
            cleanWord: cleanWord,
            isFound: false,
          ),
        );
      }
    }

    return AnalyzedSentence(
      originalSentence: sentence,
      words: analyzedWords,
      translationArabic: _generateArabicTranslation(analyzedWords),
    );
  }

  /// Extract key vocabulary from sentence
  Future<List<AnalyzedWord>> extractVocabulary(String sentence) async {
    final analyzed = await analyzeSentence(sentence);
    return analyzed.words.where((w) => w.isFound).toList();
  }

  String _generateArabicTranslation(List<AnalyzedWord> words) {
    final meanings = words
        .where((w) => w.isFound)
        .map((w) => w.meaning ?? w.word)
        .toList();
    return meanings.join(' - ');
  }
}

class AnalyzedSentence {
  final String originalSentence;
  final List<AnalyzedWord> words;
  final String? translationArabic;

  AnalyzedSentence({
    required this.originalSentence,
    required this.words,
    this.translationArabic,
  });

  int get foundWordsCount => words.where((w) => w.isFound).length;
  int get totalWordsCount => words.length;
}

class AnalyzedWord {
  final String word;
  final String cleanWord;
  final String? meaning;
  final String? partOfSpeech;
  final String? definition;
  final String? ipa;
  final bool isFound;

  AnalyzedWord({
    required this.word,
    required this.cleanWord,
    this.meaning,
    this.partOfSpeech,
    this.definition,
    this.ipa,
    required this.isFound,
  });
}
