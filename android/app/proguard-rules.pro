-keep class com.english.pocket.teacher.** { *; }
-keep class com.english.pocket.teacher.models.** { *; }
-keep class com.english.pocket.teacher.services.** { *; }
-keep class com.english.pocket.teacher.repositories.** { *; }

# Keep Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep SQLite
-keep class org.sqlite.** { *; }

# Keep TTS and Audio
-keep class android.speech.** { *; }

# Keep GetIt
-keep class get_it.** { *; }

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}
