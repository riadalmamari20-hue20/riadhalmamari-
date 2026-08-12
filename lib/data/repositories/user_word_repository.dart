import 'package:english_pocket_teacher/data/datasources/user_word_datasource.dart';
import 'package:english_pocket_teacher/data/models/user_word_model.dart';

class UserWordRepository {
  final UserWordDataSource _dataSource;

  UserWordRepository(this._dataSource);

  Future<UserWord?> getUserWord(int wordId) async {
    return _dataSource.getUserWord(wordId);
  }

  Future<List<UserWord>> getWordsForReview() async {
    return _dataSource.getWordsForReview();
  }

  Future<List<UserWord>> getNewWords({int limit = 100}) async {
    return _dataSource.getWordsByStatus('NEW', limit: limit);
  }

  Future<List<UserWord>> getLearningWords({int limit = 100}) async {
    return _dataSource.getWordsByStatus('LEARNING', limit: limit);
  }

  Future<List<UserWord>> getMasteredWords({int limit = 100}) async {
    return _dataSource.getWordsByStatus('MASTERED', limit: limit);
  }

  Future<int> addWord(UserWord userWord) async {
    return _dataSource.addUserWord(userWord);
  }

  Future<int> updateWord(UserWord userWord) async {
    return _dataSource.updateUserWord(userWord);
  }

  Future<int> removeWord(int id) async {
    return _dataSource.deleteUserWord(id);
  }
}
