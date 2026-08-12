import 'package:english_pocket_teacher/data/repositories/word_repository.dart';
import 'package:english_pocket_teacher/data/models/word_model.dart';

class SearchService {
  final WordRepository _wordRepository;

  SearchService(this._wordRepository);

  /// Search words by English word or Arabic meaning
  Future<List<Word>> search(String query, {int limit = 50}) async {
    if (query.trim().isEmpty) {
      return [];
    }
    return _wordRepository.searchWords(query.trim(), limit: limit);
  }

  /// Get word autocomplete suggestions
  Future<List<String>> getAutocompleteSuggestions(String prefix, {int limit = 10}) async {
    if (prefix.trim().isEmpty) {
      return [];
    }

    final words = await _wordRepository.searchWords(prefix.trim(), limit: limit);
    return words.map((w) => w.englishWord).toList();
  }

  /// Advanced search with filters
  Future<List<Word>> advancedSearch({
    String? query,
    String? cefr,
    String? partOfSpeech,
    int limit = 50,
  }) async {
    List<Word> results = [];

    if (query != null && query.isNotEmpty) {
      results = await _wordRepository.searchWords(query, limit: limit * 2);
    } else if (cefr != null) {
      results = await _wordRepository.getWordsByCEFR(cefr, limit: limit * 2);
    } else {
      results = await _wordRepository.getAllWords(limit: limit * 2);
    }

    // Apply filters
    if (partOfSpeech != null) {
      results = results.where((w) => w.partOfSpeech == partOfSpeech).toList();
    }

    return results.take(limit).toList();
  }

  /// Get words by CEFR level
  Future<List<Word>> getWordsByLevel(String cefr, {int limit = 100}) async {
    return _wordRepository.getWordsByCEFR(cefr, limit: limit);
  }

  /// Get random words for daily practice
  Future<List<Word>> getRandomWords({int count = 10}) async {
    final words = await _wordRepository.getAllWords(limit: count * 3);
    words.shuffle();
    return words.take(count).toList();
  }
}
