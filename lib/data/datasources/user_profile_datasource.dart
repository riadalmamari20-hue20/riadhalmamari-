import 'package:english_pocket_teacher/data/database/database_helper.dart';
import 'package:english_pocket_teacher/data/models/user_profile_model.dart';
import 'package:english_pocket_teacher/core/errors/exceptions.dart';

class UserProfileDataSource {
  final DatabaseHelper _dbHelper;

  UserProfileDataSource(this._dbHelper);

  Future<UserProfile?> getUserProfile() async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        DatabaseHelper.userProfileTable,
        limit: 1,
      );

      if (maps.isEmpty) {
        return null;
      }

      return UserProfile.fromMap(maps.first);
    } catch (e) {
      throw DatabaseException(
        message: 'Error fetching user profile: $e',
        code: 'FETCH_ERROR',
        originalException: e,
      );
    }
  }

  Future<void> createUserProfile() async {
    try {
      final db = await _dbHelper.database;
      final now = DateTime.now();
      
      await db.insert(
        DatabaseHelper.userProfileTable,
        {
          'id': 1,
          'totalXP': 0,
          'level': 1,
          'currentStreak': 0,
          'bestStreak': 0,
          'lastActivityDate': now.toIso8601String(),
          'createdAt': now.toIso8601String(),
          'wordsLearned': 0,
          'reviewsDone': 0,
        },
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Error creating user profile: $e',
        code: 'CREATE_ERROR',
        originalException: e,
      );
    }
  }

  Future<int> updateUserProfile(UserProfile profile) async {
    try {
      final db = await _dbHelper.database;
      return await db.update(
        DatabaseHelper.userProfileTable,
        profile.toMap(),
        where: 'id = ?',
        whereArgs: [profile.id],
      );
    } catch (e) {
      throw DatabaseException(
        message: 'Error updating user profile: $e',
        code: 'UPDATE_ERROR',
        originalException: e,
      );
    }
  }

  Future<void> addXP(int amount) async {
    try {
      final db = await _dbHelper.database;
      final profile = await getUserProfile();
      
      if (profile == null) {
        await createUserProfile();
      }

      final currentProfile = await getUserProfile();
      if (currentProfile != null) {
        final newXP = currentProfile.totalXP + amount;
        final newLevel = _calculateLevel(newXP);
        
        await updateUserProfile(
          currentProfile.copyWith(
            totalXP: newXP,
            level: newLevel,
            lastActivityDate: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      throw DatabaseException(
        message: 'Error adding XP: $e',
        code: 'UPDATE_ERROR',
        originalException: e,
      );
    }
  }

  int _calculateLevel(int totalXP) {
    // Simple level calculation
    return (totalXP / 500).floor() + 1;
  }
}
