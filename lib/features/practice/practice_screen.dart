import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/core/service_locator/service_locator.dart';
import 'package:english_pocket_teacher/services/learning_engine/question_generator.dart';
import 'package:english_pocket_teacher/data/repositories/word_repository.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({Key? key}) : super(key: key);

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late WordRepository _wordRepository;
  int _currentQuestion = 0;
  int _correctAnswers = 0;
  List<dynamic> _questions = [];
  String? _selectedAnswer;
  bool _answered = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _wordRepository = getIt<WordRepository>();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final words = await _wordRepository.getAllWords(limit: 10);
      setState(() {
        _questions = words
            .map((word) => QuestionGenerator.generateMultipleChoice(word, words))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _checkAnswer() {
    if (_selectedAnswer == null) return;

    setState(() => _answered = true);

    if (_selectedAnswer == _questions[_currentQuestion].correctAnswer) {
      setState(() => _correctAnswers++);
    }
  }

  void _nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete'),
        content: Text('Score: $_correctAnswers/${_questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetQuiz();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestion = 0;
      _correctAnswers = 0;
      _selectedAnswer = null;
      _answered = false;
    });
    _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No questions available')),
      );
    }

    final question = _questions[_currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestion + 1}/${_questions.length}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestion + 1) / _questions.length,
            ),
            const SizedBox(height: 24),
            Text(
              question.question,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...question.options.map<Widget>((option) {
              final isSelected = _selectedAnswer == option;
              final isCorrect = option == question.correctAnswer;
              final showResult = _answered;

              Color? backgroundColor;
              if (showResult) {
                if (isCorrect) {
                  backgroundColor = Colors.green.shade100;
                } else if (isSelected) {
                  backgroundColor = Colors.red.shade100;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: _answered ? null : () {
                      setState(() => _selectedAnswer = option);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: option,
                            groupValue: _selectedAnswer,
                            onChanged: _answered ? null : (value) {
                              setState(() => _selectedAnswer = value);
                            },
                          ),
                          Expanded(child: Text(option)),
                          if (showResult)
                            Icon(
                              isCorrect ? Icons.check : Icons.close,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _answered
                    ? _nextQuestion
                    : (_selectedAnswer != null ? _checkAnswer : null),
                child: Text(_answered ? 'Next' : 'Check Answer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
