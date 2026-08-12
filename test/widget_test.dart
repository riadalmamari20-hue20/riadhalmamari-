import 'package:flutter_test/flutter_test.dart';
import 'package:english_pocket_teacher/app/app.dart';

void main() {
  testWidgets('App initializes and shows navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const EnglishPocketTeacherApp());
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('Navigation bar has all tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const EnglishPocketTeacherApp());
    expect(find.text('Dictionary'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
