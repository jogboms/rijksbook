import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/screens.dart';

import '../utils.dart';

void main() {
  group('HomePage', () {
    testWidgets('Smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(makeApp(const HomePage()));

      expect(find.text('RijksBook'), findsOneWidget);
    });
  });
}
