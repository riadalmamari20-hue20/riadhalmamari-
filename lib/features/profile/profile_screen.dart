import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/core/service_locator/service_locator.dart';
import 'package:english_pocket_teacher/data/repositories/user_profile_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfileRepository _profileRepository;

  @override
  void initState() {
    super.initState();
    _profileRepository = getIt<UserProfileRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: _profileRepository.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No profile data'));
          }

          final profile = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          'L${profile.level}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Level ${profile.level}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Stats Grid
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  children: [
                    _buildStatCard('Total XP', '${profile.totalXP}'),
                    _buildStatCard('Current Streak', '${profile.currentStreak}'),
                    _buildStatCard('Best Streak', '${profile.bestStreak}'),
                    _buildStatCard('Words Learned', '${profile.wordsLearned}'),
                    _buildStatCard('Reviews Done', '${profile.reviewsDone}'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Achievements',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    8,
                    (index) => Center(
                      child: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
