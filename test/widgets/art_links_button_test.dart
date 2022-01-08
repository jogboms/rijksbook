import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rijksbook/domain.dart';
import 'package:rijksbook/widgets.dart';

class MockBrowser extends Mock implements ArtLinksBrowser {}

void main() async {
  group('ArtLinksButton', () {
    late MockBrowser browser;

    setUp(() {
      browser = MockBrowser();
    });

    tearDown(() {
      reset(browser);
    });

    testWidgets('it works with web url', (WidgetTester tester) async {
      const Key key = Key('button');
      await tester.pumpWidget(MaterialApp(
        home: ArtLinksButton(key: key, links: const ArtLinks(web: 'hello'), browser: browser),
      ));

      await tester.tap(find.byKey(key));

      verify(() => browser.open('hello')).called(1);
    });

    testWidgets('it works with self', (WidgetTester tester) async {
      const Key key = Key('button');
      await tester.pumpWidget(MaterialApp(
        home: ArtLinksButton(key: key, links: const ArtLinks(self: 'hello'), browser: browser),
      ));

      await tester.tap(find.byKey(key));

      verify(() => browser.open('hello')).called(1);
    });

    testWidgets('it renders empty box if url is null', (WidgetTester tester) async {
      const Key key = Key('button');
      await tester.pumpWidget(MaterialApp(
        home: ArtLinksButton(key: key, links: const ArtLinks(), browser: browser),
      ));

      await tester.tap(find.byKey(key), warnIfMissed: false);

      verifyNever(() => browser.open(any()));
    });
  });
}
