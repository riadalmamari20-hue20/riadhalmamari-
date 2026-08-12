import 'package:english_pocket_teacher/data/repositories/user_profile_repository.dart';

class StreakManager {
  final UserProfileRepository _profileRepository;

  StreakManager(this._profileRepository);

  /// Update streak for today
  Future<void> updateStreak() async {
    final profile = await _profileRepository.getUserProfile();
    if (profile == null) return;

    final now = DateTime.now();
    final lastActivity = profile.lastActivityDate;

    // Check if activity was today
    final isToday = lastActivity.year == now.year &&
        lastActivity.month == now.month &&
        lastActivity.day == now.day;

    if (isToday) {
      // Already counted today, no change
      return;
    }

    // Check if it was yesterday
    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = lastActivity.year == yesterday.year &&
        lastActivity.month == yesterday.month &&
        lastActivity.day == yesterday.day;

    late int newStreak;
    if (isYesterday) {
      // Maintain streak
      newStreak = profile.currentStreak + 1;
    } else {
      // Break or start new streak
      newStreak = 1;
    }

    // Update best streak if needed
    final newBestStreak = newStreak > profile.bestStreak ? newStreak : profile.bestStreak;

    await _profileRepository.updateProfile(
      profile.copyWith(
        currentStreak: newStreak,
        bestStreak: newBestStreak,
        lastActivityDate: now,
      ),
    );
  }

  /// Get current streak
  Future<int> getCurrentStreak() async {
    final profile = await _profileRepository.getUserProfile();
    return profile?.currentStreak ?? 0;
  }

  /// Get best streak
  Future<int> getBestStreak() async {
    final profile = await _profileRepository.getUserProfile();
    return profile?.bestStreak ?? 0;
  }
}
