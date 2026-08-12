import 'package:flutter/material.dart';
import 'package:english_pocket_teacher/app/app.dart';
import 'package:english_pocket_teacher/core/service_locator/service_locator.dart';

future void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize service locator
  await setupServiceLocator();
  
  runApp(const EnglishPocketTeacherApp());
}
