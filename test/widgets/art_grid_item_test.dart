import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:rijksbook/widgets.dart';

import '../utils.dart';

void main() {
  group('ArtGridItem', () {
    testWidgets('Smoke test', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: ArtGridItem(art: dummyArtModel, onPressed: () {})));

        expect(find.text('Lorem Ipsum'), findsOneWidget);
      });
    });
  });
}
