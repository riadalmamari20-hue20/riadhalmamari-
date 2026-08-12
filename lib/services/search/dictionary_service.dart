import 'package:english_pocket_teacher/data/repositories/word_repository.dart';
import 'package:english_pocket_teacher/data/models/word_model.dart';

class DictionaryService {
  final WordRepository _wordRepository;

  DictionaryService(this._wordRepository);

  /// Get complete word details
  Future<Word?> getWordDetails(String englishWord) async {
    return _wordRepository.getWordByEnglish(englishWord);
  }

  /// Get word by ID
  Future<Word> getWordById(int id) async {
    return _wordRepository.getWordById(id);
  }

  /// Add a word to favorites
  Future<bool> addToFavorites(Word word) async {
    try {
      await _wordRepository.updateWord(word.copyWith(isFavorite: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Remove from favorites
  Future<bool> removeFromFavorites(Word word) async {
    try {
      await _wordRepository.updateWord(word.copyWith(isFavorite: false));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get word statistics
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final totalWords = await _wordRepository.getWordCount();
      final a1Words = await _wordRepository.getWordsByCEFR('A1', limit: 10000);
      final a2Words = await _wordRepository.getWordsByCEFR('A2', limit: 10000);
      final b1Words = await _wordRepository.getWordsByCEFR('B1', limit: 10000);
      final b2Words = await _wordRepository.getWordsByCEFR('B2', limit: 10000);
      final c1Words = await _wordRepository.getWordsByCEFR('C1', limit: 10000);
      final c2Words = await _wordRepository.getWordsByCEFR('C2', limit: 10000);

      return {
        'totalWords': totalWords,
        'a1': a1Words.length,
        'a2': a2Words.length,
        'b1': b1Words.length,
        'b2': b2Words.length,
        'c1': c1Words.length,
        'c2': c2Words.length,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  /// Import words from list
  Future<int> importWords(List<Word> words) async {
    return _wordRepository.addWords(words);
  }
}
