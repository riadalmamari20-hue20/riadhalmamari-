import 'package:english_pocket_teacher/data/database/database_helper.dart';
import 'package:english_pocket_teacher/data/models/word_model.dart';
import 'package:english_pocket_teacher/core/errors/exceptions.dart';

class WordDataSource {
  final DatabaseHelper _dbHelper;

  WordDataSource(this._dbHelper);

  Future<Word> getWordById(int id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        DatabaseHelper.wordTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isEmpty) {
        throw NotFoundException(message: 'Word not found', code: 'WORD_NOT_FOUND');
      }

      return Word.fromMap(maps.first);
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw DatabaseException(
        message: 'Error fetching word: $e',
        code: 'FETCH_WORD_ERROR',
        originalException: e,
      );
    }
  }

  Future<Word?> getWordByEnglish(String english) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        DatabaseHelper.wordTable,
        where: 'englishWord = ?',
        whereArgs: [english.toLowerCase()],
        limit: 1,
      );

      return maps.isEmpty ? null : Word.fromMap(maps.first);
    } catch (e) {
      throw DatabaseException(
        message: 'Error fetching word: $e',
        code: 'FETCH_WORD_ERROR',
        originalException: e,
      );
    }
  }

  Future<List<Word>> searchWords(String query, {int limit = 50}) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.rawQuery(
        '''
        SELECT DISTINCT w.* FROM ${DatabaseHelper.wordTable} w
        WHERE w.englishWord LIKE ? OR w.arabicMeaning LIKE ?
        ORDER BY w.frequency DESC, w.englishWord ASC
        LIMIT ?
        ''',
        ['$query%', '%$query%', limit],
      );

      return maps.map((map) => Word.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(
        message: 'Error searching words: $e',
        code: 'SEARCH_ERROR',
        originalException: e,
      );
    }
  }

  Future<List<Word>> getWordsByCEFR(String cefr, {int limit = 100}) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        DatabaseHelper.wordTable,
        where: 'cefr = ?',
        whereArgs: [cefr],
        limit: limit,
      );

      return maps.map((map) => Word.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(
        message: 'Error fetching words by CEFR: $e',
        code: 'FETCH_ERROR',
        originalException: e,
      );
    }
  }

  Future<List<Word>> getAllWords({int limit = 100, int offset = 0}) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        DatabaseHelper.wordTable,
        orderBy: 'frequency DESC',
        limit: limit,
        offset: offset,
      );

      return maps.map((map) => Word.fromMap(map)).toList();
    } catch (e) {
      throw DatabaseException(
        message: 'Error fetching words: $e',
        code: 'FETCH_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> insertWord(Word word) async {
    try {
      final db = await _dbHelper.database;
      return await db.insert(
        DatabaseHelper.wordTable,
        word.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Error inserting word: $e',
        code: 'INSERT_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> insertWords(List<Word> words) async {
    try {
      final db = await _dbHelper.database;
      int count = 0;

      await db.transaction((txn) async {
        for (var word in words) {
          await txn.insert(
            DatabaseHelper.wordTable,
            word.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          count++;
        }
      });

      return count;
    } catch (e) {
      throw DatabaseException(
        message: 'Error inserting words: $e',
        code: 'BATCH_INSERT_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> updateWord(Word word) async {
    try {
      final db = await _dbHelper.database;
      return await db.update(
        DatabaseHelper.wordTable,
        word.copyWith(updatedAt: DateTime.now()).toMap(),
        where: 'id = ?',
        whereArgs: [word.id],
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Error updating word: $e',
        code: 'UPDATE_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> getWordCount() async {
    try {
      final db = await _dbHelper.database;
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM ${DatabaseHelper.wordTable}');
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw DatabaseException(
        message: 'Error getting word count: $e',
        code: 'COUNT_ERROR',
        originalException: e,
      );
    }
  }
}
