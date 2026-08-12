# English Pocket Teacher

An offline-first English dictionary, translator, and personal English teacher app with intelligent learning engine, spaced repetition, and comprehensive grammar, listening, and pronunciation support.

## Features

### Core Features
- 📚 **Comprehensive Dictionary** - 100,000+ words with full definitions, examples, and usage
- 🔍 **Smart Search** - Fuzzy search, autocomplete, typo correction, multiple search modes
- 📖 **Word Details** - IPA, pronunciation (US/UK), definitions, synonyms, antonyms, collocations, phrasal verbs, idioms
- 💾 **Offline First** - Complete functionality without internet connection
- 🎯 **Spaced Repetition System** - Smart learning algorithm that optimizes review intervals
- 📊 **Learning Analytics** - Track progress with XP, levels, streaks, and achievements
- 🎤 **Pronunciation** - US and UK English with text-to-speech support
- 📝 **Grammar Engine** - Complete grammar lessons from A1 to C2
- 👂 **Listening Practice** - Listening comprehension exercises with transcripts
- 🔤 **Sentence Analyzer** - Break down sentences by word, grammar, and meaning
- 🏆 **Gamification** - Achievements, badges, daily streaks, XP system

## Architecture

```
lib/
├── app/              # App configuration, routing, theme
├── core/             # Core utilities, constants, extensions
├── data/             # Database, models, repositories
├── features/         # Feature modules
└── services/         # Core services (audio, search, learning engine)
```

## Tech Stack

- **Framework**: Flutter 3.22+
- **Language**: Dart 3.3+
- **Database**: SQLite with FTS5
- **State Management**: GetIt (Service Locator)
- **UI**: Material Design 3
- **Audio**: AudioPlayers, flutter_tts
- **Speech**: speech_to_text

## Building

### Prerequisites
- Flutter 3.22.0 or later
- Dart 3.3.0 or later
- Android SDK 21 or higher
- Java JDK 11+

### Development Build

```bash
# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run
```

### Release Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Google Play)
flutter build appbundle --release
```

Built files will be in:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

## Quality Assurance

```bash
# Analyze code
flutter analyze

# Run tests
flutter test

# Run integration tests
flutter test integration_test
```

## Contributing

Please ensure:
- All tests pass
- Code is properly formatted
- No lints or warnings
- Meaningful commit messages

## License

ProprietaryRightReserved © 2024
