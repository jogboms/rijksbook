import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:rijksbook/widgets.dart';

import '../mocks.dart';
import '../utils.dart';

void main() {
  group('ArtGridItem', () {
    testWidgets('Smoke test', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        late bool pressed;
        await tester.pumpWidget(makeApp(home: ArtGridItem(art: dummyArtModel, onPressed: () => pressed = true)));

        expect(find.text('Lorem Ipsum'), findsOneWidget);
        expect(find.text('Name with Lorem Ipsum'), findsOneWidget);
        expect(find.byKey(const Key('imageUrl')), findsOneWidget);

        await tester.tap(find.byKey(ArtGridItem.inkWellBoxKey));

        expect(pressed, true);
      });
    });
  });
}
