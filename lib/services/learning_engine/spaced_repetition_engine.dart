/// Spaced Repetition Algorithm (SM-2)
/// Based on the SuperMemo 2 algorithm
class SpacedRepetitionEngine {
  // SM-2 constants
  static const double initialEase = 2.5;
  static const int initialInterval = 1;
  static const double easyBonus = 1.3;
  static const double hardPenalty = 0.6;
  static const int minimumEase = 130; // 1.3 in internal format
  static const int maximumEase = 250; // 2.5 in internal format

  /// Calculate next review interval based on quality of response
  /// quality: 0 = forget, 1 = difficult, 2 = ok, 3 = good, 4 = excellent
  static ReviewSchedule calculateNextReview({
    required int currentEase, // 1000 = 1.0
    required int currentInterval,
    required int repetitions,
    required int lapses,
    required int quality,
  }) {
    if (quality < 0 || quality > 4) {
      throw ArgumentError('Quality must be between 0 and 4');
    }

    int newEase = currentEase;
    int newInterval = currentInterval;
    int newRepetitions = repetitions;
    int newLapses = lapses;
    String newStatus = 'LEARNING';

    // Adjust ease factor
    newEase = (currentEase + (quality - 2) * 10).toInt();
    newEase = newEase.clamp(minimumEase, maximumEase);

    if (quality < 2) {
      // Forgot or found it difficult
      newLapses++;
      newInterval = 1;
      newRepetitions = 0;
      newStatus = 'LEARNING';
    } else {
      // Remembered it
      newRepetitions++;

      if (newRepetitions == 1) {
        newInterval = 1;
      } else if (newRepetitions == 2) {
        newInterval = 3;
      } else {
        newInterval = ((currentInterval * newEase) / 1000).ceil();
      }

      // Determine status
      if (newRepetitions >= 3) {
        newStatus = 'MASTERED';
      } else {
        newStatus = 'LEARNING';
      }
    }

    final nextReviewDate = DateTime.now().add(Duration(days: newInterval));

    return ReviewSchedule(
      interval: newInterval,
      ease: newEase,
      nextReviewDate: nextReviewDate,
      repetitions: newRepetitions,
      lapses: newLapses,
      status: newStatus,
    );
  }

  /// Get human-readable status for a card
  static String getCardStatus(int repetitions, int lapses) {
    if (repetitions == 0) return 'NEW';
    if (repetitions < 3) return 'LEARNING';
    if (lapses > 0) return 'RELEARNING';
    return 'MASTERED';
  }

  /// Check if card is due for review
  static bool isCardDue(DateTime nextReviewDate) {
    return nextReviewDate.isBefore(DateTime.now());
  }
}

class ReviewSchedule {
  final int interval;
  final int ease;
  final DateTime nextReviewDate;
  final int repetitions;
  final int lapses;
  final String status;

  ReviewSchedule({
    required this.interval,
    required this.ease,
    required this.nextReviewDate,
    required this.repetitions,
    required this.lapses,
    required this.status,
  });
}
