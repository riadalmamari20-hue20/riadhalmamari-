import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/core/service_locator/service_locator.dart';
import 'package:english_pocket_teacher/services/search/search_service.dart';
import 'package:english_pocket_teacher/services/search/dictionary_service.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  late SearchService _searchService;
  late DictionaryService _dictionaryService;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchService = getIt<SearchService>();
    _dictionaryService = getIt<DictionaryService>();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final results = await _searchService.search(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search words...',
              onChanged: _performSearch,
              leading: const Icon(Icons.search),
              trailing: _searchController.text.isNotEmpty
                  ? [
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchResults = []);
                        },
                      ),
                    ]
                  : [],
            ),
          ),
          if (_isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_searchResults.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  _searchController.text.isEmpty
                      ? 'Search for words...'
                      : 'No results found',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final word = _searchResults[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        word.englishWord[0].toUpperCase(),
                      ),
                    ),
                    title: Text(word.englishWord),
                    subtitle: Text(word.arabicMeaning),
                    trailing: Chip(
                      label: Text(word.cefr ?? 'N/A'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WordDetailScreen(word: word),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class WordDetailScreen extends StatelessWidget {
  final dynamic word;

  const WordDetailScreen({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioService = getIt<AudioService>();

    return Scaffold(
      appBar: AppBar(
        title: Text(word.englishWord),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      word.englishWord,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (word.ipa != null)
                      Text(
                        'IPA: ${word.ipa}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    if (word.partOfSpeech != null)
                      Chip(label: Text(word.partOfSpeech)),
                    if (word.cefr != null)
                      Chip(label: Text('CEFR: ${word.cefr}')),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.volume_up),
                          label: const Text('US'),
                          onPressed: () {
                            audioService.speakUSEnglish(word.englishWord);
                          },
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.volume_up),
                          label: const Text('UK'),
                          onPressed: () {
                            audioService.speakUKEnglish(word.englishWord);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Arabic Meaning',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              word.arabicMeaning,
              style: const TextStyle(fontSize: 16),
            ),
            if (word.definition != null) ...[const SizedBox(height: 16),
              const Text(
                'Definition',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                word.definition,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
