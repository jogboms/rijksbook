import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:rijksbook/screens.dart';
import 'package:rijksbook/widgets.dart';

import '../mocks.dart';
import '../utils.dart';

void main() {
  group('DetailsPage', () {
    late MockRijksRepository repository;

    setUp(() {
      repository = MockRijksRepository();
    });

    tearDown(() {
      reset(repository);
    });

    testWidgets('Smoke test', (WidgetTester tester) async {
      when(() => repository.fetch(any())).thenAnswer((_) async => dummyArtDetailModel);

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: DetailsPage(art: dummyArtModel), repository: repository));

        expect(find.byKey(LoadingSpinner.defaultKey), findsOneWidget);

        await tester.pump();

        expect(find.byKey(Key(dummyArtModel.id)), findsOneWidget);
      });
    });

    group('Error handling', () {
      testWidgets('can handle initializing fetch error', (WidgetTester tester) async {
        when(() => repository.fetch(any())).thenThrow(Exception('Error'));

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeApp(home: DetailsPage(art: dummyArtModel), repository: repository));

          await tester.pump();

          expect(find.byKey(DetailsPage.errorBoxKey), findsOneWidget);
          expect(find.text('Exception: Error'), findsOneWidget);
        });
      });
    });

    testWidgets('can handle initializing fetch error and retry', (WidgetTester tester) async {
      int requestCount = 0;
      when(() => repository.fetch(any())).thenAnswer((_) async {
        if (requestCount == 0) {
          requestCount++;
          throw Exception('Error');
        }
        return dummyArtDetailModel;
      });

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: DetailsPage(art: dummyArtModel), repository: repository));

        await tester.pump();

        expect(find.byKey(DetailsPage.errorBoxKey), findsOneWidget);

        await tester.tap(find.widgetWithText(TextButton, 'RETRY'));

        verify(() => repository.fetch(any())).called(2);
      });
    });

    testWidgets('can handle initializing fetch error, retry and continue', (WidgetTester tester) async {
      int requestCount = 0;
      when(() => repository.fetch(any())).thenAnswer((_) async {
        if (requestCount == 0) {
          requestCount++;
          throw Exception('Error');
        }
        return dummyArtDetailModel;
      });

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: DetailsPage(art: dummyArtModel), repository: repository));

        await tester.pump();

        expect(find.byKey(DetailsPage.errorBoxKey), findsOneWidget);

        await tester.tap(find.widgetWithText(TextButton, 'RETRY'));

        verify(() => repository.fetch(any())).called(2);

        await tester.pump();

        expect(find.byKey(Key(dummyArtModel.id)), findsOneWidget);
      });
    });

    testWidgets('should show image dialog with image', (WidgetTester tester) async {
      when(() => repository.fetch(any())).thenAnswer((_) async => dummyArtDetailModel);

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: DetailsPage(art: dummyArtModel), repository: repository));

        await tester.pump();

        await tester.tap(find.byKey(DetailsPage.zoomButtonKey));

        await tester.pump();

        expect(find.byType(ImageDialog), findsOneWidget);
        expect(find.byType(CloseButton), findsOneWidget);
        expect(find.byKey(const Key('dialog-imageUrl')), findsOneWidget);
      });
    });
  });
}
