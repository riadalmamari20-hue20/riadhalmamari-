import 'package:english_pocket_teacher/core/service_locator/service_locator.dart';
import 'package:english_pocket_teacher/data/database/database_helper.dart';
import 'package:english_pocket_teacher/data/datasources/word_datasource.dart';
import 'package:english_pocket_teacher/data/datasources/user_word_datasource.dart';
import 'package:english_pocket_teacher/data/datasources/user_profile_datasource.dart';
import 'package:english_pocket_teacher/data/repositories/word_repository.dart';
import 'package:english_pocket_teacher/data/repositories/user_word_repository.dart';
import 'package:english_pocket_teacher/data/repositories/user_profile_repository.dart';
import 'package:english_pocket_teacher/services/audio/audio_service.dart';
import 'package:english_pocket_teacher/services/search/search_service.dart';
import 'package:english_pocket_teacher/services/search/dictionary_service.dart';
import 'package:english_pocket_teacher/services/search/sentence_analyzer_service.dart';
import 'package:english_pocket_teacher/services/learning_engine/xp_manager.dart';
import 'package:english_pocket_teacher/services/learning_engine/streak_manager.dart';

Future<void> setupServiceLocator() async {
  // Database
  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper());

  // Datasources
  getIt.registerSingleton<WordDataSource>(
    WordDataSource(getIt<DatabaseHelper>()),
  );
  getIt.registerSingleton<UserWordDataSource>(
    UserWordDataSource(getIt<DatabaseHelper>()),
  );
  getIt.registerSingleton<UserProfileDataSource>(
    UserProfileDataSource(getIt<DatabaseHelper>()),
  );

  // Repositories
  getIt.registerSingleton<WordRepository>(
    WordRepository(getIt<WordDataSource>()),
  );
  getIt.registerSingleton<UserWordRepository>(
    UserWordRepository(getIt<UserWordDataSource>()),
  );
  getIt.registerSingleton<UserProfileRepository>(
    UserProfileRepository(getIt<UserProfileDataSource>()),
  );

  // Services
  getIt.registerSingleton<AudioService>(AudioService());
  getIt.registerSingleton<SearchService>(
    SearchService(getIt<WordRepository>()),
  );
  getIt.registerSingleton<DictionaryService>(
    DictionaryService(getIt<WordRepository>()),
  );
  getIt.registerSingleton<SentenceAnalyzerService>(
    SentenceAnalyzerService(getIt<WordRepository>()),
  );
  getIt.registerSingleton<XPManager>(
    XPManager(getIt<UserProfileRepository>()),
  );
  getIt.registerSingleton<StreakManager>(
    StreakManager(getIt<UserProfileRepository>()),
  );
}
