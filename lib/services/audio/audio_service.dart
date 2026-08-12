import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  late FlutterTts _flutterTts;
  bool _isInitialized = false;

  AudioService() {
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    _flutterTts = FlutterTts();
    
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(1.0);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      _isInitialized = true;
    } catch (e) {
      print('Error initializing TTS: $e');
    }
  }

  /// Speak word in US English
  Future<void> speakUSEnglish(String word) async {
    if (!_isInitialized) await _initializeTTS();
    
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.speak(word);
    } catch (e) {
      print('Error speaking: $e');
    }
  }

  /// Speak word in UK English
  Future<void> speakUKEnglish(String word) async {
    if (!_isInitialized) await _initializeTTS();
    
    try {
      await _flutterTts.setLanguage('en-GB');
      await _flutterTts.speak(word);
    } catch (e) {
      print('Error speaking: $e');
    }
  }

  /// Speak Arabic text
  Future<void> speakArabic(String text) async {
    if (!_isInitialized) await _initializeTTS();
    
    try {
      await _flutterTts.setLanguage('ar');
      await _flutterTts.speak(text);
    } catch (e) {
      print('Error speaking Arabic: $e');
    }
  }

  /// Set speech rate
  Future<void> setSpeechRate(double rate) async {
    if (!_isInitialized) await _initializeTTS();
    
    try {
      await _flutterTts.setSpeechRate(rate.clamp(0.5, 2.0));
    } catch (e) {
      print('Error setting speech rate: $e');
    }
  }

  /// Set volume
  Future<void> setVolume(double volume) async {
    if (!_isInitialized) await _initializeTTS();
    
    try {
      await _flutterTts.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      print('Error setting volume: $e');
    }
  }

  /// Stop speaking
  Future<void> stop() async {
    if (!_isInitialized) return;
    
    try {
      await _flutterTts.stop();
    } catch (e) {
      print('Error stopping: $e');
    }
  }

  /// Dispose
  Future<void> dispose() async {
    if (_isInitialized) {
      await _flutterTts.stop();
    }
  }
}
