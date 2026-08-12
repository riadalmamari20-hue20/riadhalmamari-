# English Pocket Teacher

## Overview

English Pocket Teacher is a production-ready Android application providing an offline-first English dictionary, translator, and personal English teacher with intelligent learning engine, spaced repetition system, and comprehensive grammar, listening, and pronunciation support.

## Architecture

```
lib/
├── app/                    # App configuration, routing, theme
│   ├── app.dart
│   ├── router/
│   └── theme/
│
├── core/                   # Core utilities, constants, extensions
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── utils/
│   └── widgets/
│
├── data/                   # Database, models, repositories
│   ├── database/
│   ├── models/
│   ├── repositories/
│   └── datasources/
│
├── features/               # Feature modules
│   ├── home/
│   ├── dictionary/
│   ├── learning/
│   ├── practice/
│   ├── grammar/
│   ├── listening/
│   ├── pronunciation/
│   ├── sentence_analyzer/
│   ├── favorites/
│   ├── history/
│   ├── achievements/
│   └── profile/
│
└── services/               # Core services
    ├── audio/
    ├── speech/
    ├── learning_engine/
    └── search/
```

## Tech Stack

- Flutter 3.22+
- Dart 3.3+
- SQLite with FTS5
- Material Design 3
- GetIt (Service Locator)

## Building

### Requirements
- Flutter 3.22.0+
- Dart 3.3.0+
- Android SDK 21+
- Java JDK 11+

### Development

```bash
flutter pub get
flutter run
```

### Release

```bash
flutter analyze
flutter test
flutter build apk --release
flutter build appbundle --release
```

## License

ProprietaryRightReserved © 2024
