import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/screens.dart';

import '../utils.dart';

void main() {
  group('DetailsPage', () {
    testWidgets('Smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(makeApp(DetailsPage(art: dummyArtModel)));

      expect(find.text('Hello world'), findsOneWidget);
    });
  });
}
