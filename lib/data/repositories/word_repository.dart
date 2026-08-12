import 'package:english_pocket_teacher/data/datasources/word_datasource.dart';
import 'package:english_pocket_teacher/data/models/word_model.dart';
import 'package:english_pocket_teacher/core/errors/exceptions.dart';

class WordRepository {
  final WordDataSource _dataSource;

  WordRepository(this._dataSource);

  Future<Word> getWordById(int id) async {
    return _dataSource.getWordById(id);
  }

  Future<Word?> getWordByEnglish(String english) async {
    return _dataSource.getWordByEnglish(english);
  }

  Future<List<Word>> searchWords(String query, {int limit = 50}) async {
    if (query.isEmpty) {
      return [];
    }
    return _dataSource.searchWords(query, limit: limit);
  }

  Future<List<Word>> getWordsByCEFR(String cefr, {int limit = 100}) async {
    return _dataSource.getWordsByCEFR(cefr, limit: limit);
  }

  Future<List<Word>> getAllWords({int limit = 100, int offset = 0}) async {
    return _dataSource.getAllWords(limit: limit, offset: offset);
  }

  Future<int> addWord(Word word) async {
    return _dataSource.insertWord(word);
  }

  Future<int> addWords(List<Word> words) async {
    if (words.isEmpty) {
      throw ValidationException(
        message: 'Cannot add empty word list',
        code: 'VALIDATION_ERROR',
      );
    }
    return _dataSource.insertWords(words);
  }

  Future<int> updateWord(Word word) async {
    return _dataSource.updateWord(word);
  }

  Future<int> getWordCount() async {
    return _dataSource.getWordCount();
  }
}
