import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/app/theme/app_theme.dart';

class EnglishPocketTeacherApp extends StatelessWidget {
  const EnglishPocketTeacherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Pocket Teacher',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Pocket Teacher'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to English Pocket Teacher',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your offline English teacher, dictionary, and learning companion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildFeatureCard(
              icon: Icons.book,
              title: 'Dictionary',
              description: '100,000+ words with full details',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.school,
              title: 'Learning',
              description: 'Smart spaced repetition system',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.edit,
              title: 'Practice',
              description: 'Multiple question types and exercises',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.grammar,
              title: 'Grammar',
              description: 'Complete grammar lessons A1-C2',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.headphones,
              title: 'Listening',
              description: 'Listening comprehension practice',
            ),
            const SizedBox(height: 12),
            _buildFeatureCard(
              icon: Icons.mic,
              title: 'Pronunciation',
              description: 'US & UK English with TTS',
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text('Get Started'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
