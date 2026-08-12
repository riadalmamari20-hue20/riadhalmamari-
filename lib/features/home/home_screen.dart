import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/core/service_locator/service_locator.dart';
import 'package:english_pocket_teacher/services/learning_engine/xp_manager.dart';
import 'package:english_pocket_teacher/data/repositories/user_profile_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserProfileRepository _profileRepository;
  late XPManager _xpManager;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _profileRepository = getIt<UserProfileRepository>();
    _xpManager = getIt<XPManager>();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    await _profileRepository.initializeProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Pocket Teacher'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _profileRepository.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Error loading profile'));
          }

          final profile = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Summary Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text('Level', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '${profile.level}',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('XP', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '${profile.totalXP}',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Streak', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '${profile.currentStreak}',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Learned', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(
                                  '${profile.wordsLearned}',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Features Grid
                const Text(
                  'Features',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.book,
                      title: 'Dictionary',
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      icon: Icons.school,
                      title: 'Learning',
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      icon: Icons.edit,
                      title: 'Practice',
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      icon: Icons.grading,
                      title: 'Grammar',
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      icon: Icons.headphones,
                      title: 'Listening',
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      icon: Icons.mic,
                      title: 'Pronunciation',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Dictionary'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Practice'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
