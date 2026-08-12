import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:english_pocket_teacher/core/errors/exceptions.dart';

class DatabaseHelper {
  static const String _databaseName = 'english_pocket_teacher.db';
  static const int _databaseVersion = 1;

  static const String wordTable = 'words';
  static const String wordExampleTable = 'word_examples';
  static const String synonymTable = 'synonyms';
  static const String antonymTable = 'antonyms';
  static const String userWordTable = 'user_words';
  static const String userProfileTable = 'user_profile';
  static const String achievementTable = 'achievements';
  static const String searchHistoryTable = 'search_history';
  static const String grammarLessonTable = 'grammar_lessons';
  static const String dailyActivityTable = 'daily_activity';

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, _databaseName);

      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to initialize database: $e',
        code: 'DB_INIT_ERROR',
        originalException: e,
      );
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      // Words table
      await db.execute('''
        CREATE TABLE $wordTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          englishWord TEXT NOT NULL UNIQUE,
          arabicMeaning TEXT NOT NULL,
          ipa TEXT,
          usaPronunciation TEXT,
          ukPronunciation TEXT,
          partOfSpeech TEXT,
          cefr TEXT,
          definition TEXT,
          createdAt TEXT NOT NULL,
          updatedAt TEXT,
          frequency INTEGER DEFAULT 0,
          isFavorite INTEGER DEFAULT 0
        )
      ''');

      // Create FTS5 virtual table for full-text search
      await db.execute('''
        CREATE VIRTUAL TABLE ${wordTable}_fts USING fts5(
          englishWord,
          arabicMeaning,
          definition,
          content=$wordTable,
          content_rowid=id
        )
      ''');

      // Word examples table
      await db.execute('''
        CREATE TABLE $wordExampleTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          wordId INTEGER NOT NULL,
          example TEXT NOT NULL,
          arabicTranslation TEXT,
          createdAt TEXT NOT NULL,
          FOREIGN KEY (wordId) REFERENCES $wordTable (id) ON DELETE CASCADE
        )
      ''');

      // Synonyms table
      await db.execute('''
        CREATE TABLE $synonymTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          wordId INTEGER NOT NULL,
          synonymWord TEXT NOT NULL,
          definition TEXT,
          FOREIGN KEY (wordId) REFERENCES $wordTable (id) ON DELETE CASCADE
        )
      ''');

      // Antonyms table
      await db.execute('''
        CREATE TABLE $antonymTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          wordId INTEGER NOT NULL,
          antonymWord TEXT NOT NULL,
          definition TEXT,
          FOREIGN KEY (wordId) REFERENCES $wordTable (id) ON DELETE CASCADE
        )
      ''');

      // User words table (learning progress)
      await db.execute('''
        CREATE TABLE $userWordTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          wordId INTEGER NOT NULL UNIQUE,
          dateAdded TEXT NOT NULL,
          timesReviewed INTEGER DEFAULT 0,
          correctAnswers INTEGER DEFAULT 0,
          incorrectAnswers INTEGER DEFAULT 0,
          status TEXT DEFAULT 'NEW',
          lastReviewDate TEXT,
          nextReviewDate TEXT,
          ease INTEGER DEFAULT 2500,
          interval INTEGER DEFAULT 1,
          repetitions INTEGER DEFAULT 0,
          lapses INTEGER DEFAULT 0,
          FOREIGN KEY (wordId) REFERENCES $wordTable (id) ON DELETE CASCADE
        )
      ''');

      // User profile table
      await db.execute('''
        CREATE TABLE $userProfileTable (
          id INTEGER PRIMARY KEY,
          totalXP INTEGER DEFAULT 0,
          level INTEGER DEFAULT 1,
          currentStreak INTEGER DEFAULT 0,
          bestStreak INTEGER DEFAULT 0,
          lastActivityDate TEXT NOT NULL,
          createdAt TEXT NOT NULL,
          wordsLearned INTEGER DEFAULT 0,
          reviewsDone INTEGER DEFAULT 0
        )
      ''');

      // Achievements table
      await db.execute('''
        CREATE TABLE $achievementTable (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          icon TEXT,
          category TEXT,
          requiredValue INTEGER,
          isUnlocked INTEGER DEFAULT 0,
          unlockedDate TEXT
        )
      ''');

      // Search history table
      await db.execute('''
        CREATE TABLE $searchHistoryTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          query TEXT NOT NULL,
          searchDate TEXT NOT NULL,
          resultCount INTEGER DEFAULT 0
        )
      ''');

      // Grammar lessons table
      await db.execute('''
        CREATE TABLE $grammarLessonTable (
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT,
          content TEXT,
          level TEXT,
          category TEXT
        )
      ''');

      // Daily activity table
      await db.execute('''
        CREATE TABLE $dailyActivityTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL UNIQUE,
          xpEarned INTEGER DEFAULT 0,
          wordsAdded INTEGER DEFAULT 0,
          reviewsCompleted INTEGER DEFAULT 0
        )
      ''');

      // Create indexes for performance
      await db.execute('CREATE INDEX idx_words_cefr ON $wordTable(cefr)');
      await db.execute('CREATE INDEX idx_words_pos ON $wordTable(partOfSpeech)');
      await db.execute('CREATE INDEX idx_user_words_status ON $userWordTable(status)');
      await db.execute('CREATE INDEX idx_user_words_next_review ON $userWordTable(nextReviewDate)');
      await db.execute('CREATE INDEX idx_search_history_date ON $searchHistoryTable(searchDate)');
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to create database tables: $e',
        code: 'DB_CREATE_ERROR',
        originalException: e,
      );
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
  }

  Future<void> close() async {
    _database?.close();
    _database = null;
  }

  Future<void> deleteDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, _databaseName);
      await sqflite.deleteDatabase(path);
      _database = null;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to delete database: $e',
        code: 'DB_DELETE_ERROR',
        originalException: e,
      );
    }
  }
}
