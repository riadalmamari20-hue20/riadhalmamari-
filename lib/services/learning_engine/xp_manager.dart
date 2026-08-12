import 'package:english_pocket_teacher/data/repositories/user_profile_repository.dart';
import 'package:english_pocket_teacher/core/constants/app_constants.dart';

class XPManager {
  final UserProfileRepository _profileRepository;

  XPManager(this._profileRepository);

  /// Award XP for adding a new word
  Future<void> awardNewWordXP() async {
    await _profileRepository.addXP(AppConstants.xpPerNewWord);
  }

  /// Award XP for correct answer
  Future<void> awardCorrectAnswerXP() async {
    await _profileRepository.addXP(AppConstants.xpPerCorrectAnswer);
  }

  /// Award XP for review
  Future<void> awardReviewXP() async {
    await _profileRepository.addXP(AppConstants.xpPerReview);
  }

  /// Award XP for lesson completion
  Future<void> awardLessonCompletionXP() async {
    await _profileRepository.addXP(AppConstants.xpPerLessonCompletion);
  }

  /// Award XP for streak
  Future<void> awardStreakBonusXP(int streakDays) async {
    final bonus = (streakDays * 5).clamp(0, 100); // Max 100 bonus
    await _profileRepository.addXP(bonus);
  }

  /// Calculate current level based on XP
  int calculateLevel(int totalXP) {
    for (int i = AppConstants.levelXpThresholds.length - 1; i >= 0; i--) {
      if (totalXP >= AppConstants.levelXpThresholds[i]) {
        return i + 1;
      }
    }
    return 1;
  }

  /// Get XP needed to reach next level
  int xpToNextLevel(int totalXP) {
    final currentLevel = calculateLevel(totalXP);
    if (currentLevel >= AppConstants.levelXpThresholds.length) {
      return 0; // Max level reached
    }
    return AppConstants.levelXpThresholds[currentLevel] - totalXP;
  }
}
