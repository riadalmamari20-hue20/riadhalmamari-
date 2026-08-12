class Achievement {
  final int id;
  final String title;
  final String description;
  final String icon;
  final String category;
  final int requiredValue;
  final bool isUnlocked;
  final DateTime? unlockedDate;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.requiredValue,
    this.isUnlocked = false,
    this.unlockedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'category': category,
      'requiredValue': requiredValue,
      'isUnlocked': isUnlocked ? 1 : 0,
      'unlockedDate': unlockedDate?.toIso8601String(),
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
      category: map['category'] as String,
      requiredValue: map['requiredValue'] as int,
      isUnlocked: (map['isUnlocked'] as int? ?? 0) == 1,
      unlockedDate: map['unlockedDate'] != null ? DateTime.parse(map['unlockedDate'] as String) : null,
    );
  }
}
