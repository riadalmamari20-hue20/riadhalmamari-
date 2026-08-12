import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/app/theme/app_theme.dart';
import 'package:english_pocket_teacher/features/navigation/main_navigation_screen.dart';

class EnglishPocketTeacherApp extends StatelessWidget {
  const EnglishPocketTeacherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Pocket Teacher',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
