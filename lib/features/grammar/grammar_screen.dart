import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/services/learning_engine/grammar_model.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({Key? key}) : super(key: key);

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  final List<GrammarLesson> _lessons = [
    GrammarLesson(
      id: 1,
      title: 'Present Simple',
      description: 'Learn about the present simple tense',
      content: 'The present simple is used for habits, general truths, and routines.',
      level: 'A1',
      category: 'Tense',
      examples: ['I eat breakfast.', 'She works in an office.'],
      rules: [
        GrammarRule(
          title: 'Affirmative',
          explanation: 'Subject + verb + object',
          examples: ['I like cats', 'He plays football'],
        ),
      ],
    ),
    GrammarLesson(
      id: 2,
      title: 'Present Continuous',
      description: 'Learn about the present continuous tense',
      content: 'The present continuous is used for actions happening now.',
      level: 'A1',
      category: 'Tense',
      examples: ['I am eating breakfast.', 'She is working in an office.'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grammar'),
      ),
      body: ListView.builder(
        itemCount: _lessons.length,
        itemBuilder: (context, index) {
          final lesson = _lessons[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(lesson.level),
              ),
              title: Text(lesson.title),
              subtitle: Text(lesson.description),
              trailing: Chip(label: Text(lesson.category)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GrammarLessonScreen(lesson: lesson),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class GrammarLessonScreen extends StatelessWidget {
  final GrammarLesson lesson;

  const GrammarLessonScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(label: Text('Level: ${lesson.level}')),
            const SizedBox(height: 16),
            const Text(
              'Explanation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              lesson.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...lesson.examples.map(
              (example) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('• $example'),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Practice Exercises'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
