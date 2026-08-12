import 'package:flutter/material.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({Key? key}) : super(key: key);

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Listening Lessons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sample Listening Lesson',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Level: A1 | Duration: 2:30',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    // Player controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            setState(() => _isPlaying = !_isPlaying);
                          },
                          child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                        ),
                        const SizedBox(width: 16),
                        DropdownButton<double>(
                          value: _playbackSpeed,
                          items: const [
                            DropdownMenuItem(value: 0.75, child: Text('0.75x')),
                            DropdownMenuItem(value: 1.0, child: Text('1.0x')),
                            DropdownMenuItem(value: 1.25, child: Text('1.25x')),
                            DropdownMenuItem(value: 1.5, child: Text('1.5x')),
                          ],
                          onChanged: (value) {
                            setState(() => _playbackSpeed = value ?? 1.0);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Progress bar
                    LinearProgressIndicator(
                      value: 0.35,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0:52'),
                        Text('2:30'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Transcript',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Sample transcript of the audio will appear here...',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
