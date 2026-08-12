import 'package:flutter_test/flutter_test.dart';
import 'package:english_pocket_teacher/main.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const EnglishPocketTeacherApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Home screen displays feature cards', (WidgetTester tester) async {
    await tester.pumpWidget(const EnglishPocketTeacherApp());
    expect(find.text('Dictionary'), findsOneWidget);
    expect(find.text('Learning'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
  });
}
