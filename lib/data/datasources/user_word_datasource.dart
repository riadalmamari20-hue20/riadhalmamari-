import 'package:english_pocket_teacher/data/database/database_helper.dart';
import 'package:english_pocket_teacher/data/models/user_word_model.dart';
import 'package:english_pocket_teacher/core/errors/exceptions.dart';

class UserWordDataSource {
  final DatabaseHelper _dbHelper;

  UserWordDataSource(this._dbHelper);

  Future<UserWord?> getUserWord(int wordId) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        DatabaseHelper.userWordTable,
        where: 'wordId = ?',
        whereArgs: [wordId],
      );

      return maps.isEmpty ? null : UserWord.fromMap(maps.first);
    } catch (e) {
      throw DatabaseException(
        message: 'Error fetching user word: $e',
        code: 'FETCH_ERROR',
        originalException: e,
      );
    }
  }

  Future<List<UserWord>> getWordsForReview() async {
    try {
      final db = await _dbHelper.database;
      final now = DateTime.now().toIso8601String();
      final maps = await db.query(
        DatabaseHelper.userWordTable,
        where: 'nextReviewDate <= ?',
        whereArgs: [now],
        orderBy: 'nextReviewDate ASC',
      );

      return maps.map((map) => UserWord.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(
        message: 'Error fetching review words: $e',
        code: 'FETCH_ERROR',
        originalException: e,
      );
    }
  }

  Future<List<UserWord>> getWordsByStatus(String status, {int limit = 100}) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        DatabaseHelper.userWordTable,
        where: 'status = ?',
        whereArgs: [status],
        limit: limit,
      );

      return maps.map((map) => UserWord.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(
        message: 'Error fetching words by status: $e',
        code: 'FETCH_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> addUserWord(UserWord userWord) async {
    try {
      final db = await _dbHelper.database;
      return await db.insert(
        DatabaseHelper.userWordTable,
        userWord.toMap(),
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Error adding word: $e',
        code: 'INSERT_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> updateUserWord(UserWord userWord) async {
    try {
      final db = await _dbHelper.database;
      return await db.update(
        DatabaseHelper.userWordTable,
        userWord.toMap(),
        where: 'id = ?',
        whereArgs: [userWord.id],
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Error updating word: $e',
        code: 'UPDATE_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> deleteUserWord(int id) async {
    try {
      final db = await _dbHelper.database;
      return await db.delete(
        DatabaseHelper.userWordTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Error deleting word: $e',
        code: 'DELETE_ERROR',
        originalException: e,
      );
    }
  }
}
