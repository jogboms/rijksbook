import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/app.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Hello world'), findsOneWidget);
  });
}
