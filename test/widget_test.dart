import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aa_generator/app.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: AaGeneratorApp()),
    );
    expect(find.text('ASCIIアートジェネレーター'), findsOneWidget);
  });
}
