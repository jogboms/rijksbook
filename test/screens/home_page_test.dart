import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:rijksbook/screens.dart';
import 'package:rijksbook/widgets.dart';

import '../mocks.dart';
import '../utils.dart';

void main() {
  group('HomePage', () {
    late MockRijksRepository repository;

    setUp(() {
      repository = MockRijksRepository();
    });

    tearDown(() {
      reset(repository);
    });

    testWidgets('Smoke test', (WidgetTester tester) async {
      when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((_) async => dummyArtModelList);

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

        expect(find.byKey(LoadingSpinner.defaultKey), findsOneWidget);

        await tester.pump();

        expect(find.byType(SliverGrid), findsOneWidget);
      });
    });

    testWidgets('Item navigates to details page when tapped', (WidgetTester tester) async {
      when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((_) async => dummyArtModelList);
      when(() => repository.fetch(any())).thenAnswer((_) async => dummyArtDetailModel);

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

        await tester.pump();

        await tester.tap(find.byKey(const ValueKey<String>('0')));

        await tester.pump();
        await tester.pump();

        expect(find.byType(DetailsPage), findsOneWidget);
      });
    });

    testWidgets('can load more data on overscroll', (WidgetTester tester) async {
      when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((Invocation inv) async {
        final int page = inv.namedArguments[const Symbol('page')] as int;
        const int perPage = 8;
        return dummyArtModelList.sublist((page - 1) * perPage, page * perPage);
      });

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

        await tester.pump();

        final Finder overscrollBox = find.byKey(HomePage.overscrollBoxKey);
        await tester.scrollUntilVisible(overscrollBox, 500.0);

        expect(overscrollBox, findsOneWidget);

        verify(() => repository.fetchAll(page: 2)).called(1);

        await tester.pump();

        final Finder lastFetchedItem = find.byKey(const Key('15'));
        await tester.scrollUntilVisible(lastFetchedItem, 500.0);

        expect(lastFetchedItem, findsOneWidget);
      });
    });

    group('Error handling', () {
      testWidgets('can handle initializing fetch error', (WidgetTester tester) async {
        when(() => repository.fetchAll(page: any(named: 'page'))).thenThrow(Exception('Error'));

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

          await tester.pump();

          expect(find.byKey(HomePage.errorBoxKey), findsOneWidget);
          expect(find.text('Exception: Error'), findsOneWidget);
        });
      });

      testWidgets('can handle initializing fetch error and retry', (WidgetTester tester) async {
        int requestCount = 0;
        when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((_) async {
          if (requestCount == 0) {
            requestCount++;
            throw Exception('Error');
          }
          return dummyArtModelList;
        });

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

          await tester.pump();

          expect(find.byKey(HomePage.errorBoxKey), findsOneWidget);

          await tester.tap(find.widgetWithText(TextButton, 'RETRY'));

          verify(() => repository.fetchAll(page: 1)).called(2);
        });
      });

      testWidgets('can handle initializing fetch error, retry and continue', (WidgetTester tester) async {
        int requestCount = 0;
        when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((_) async {
          if (requestCount == 0) {
            requestCount++;
            throw Exception('Error');
          }
          return dummyArtModelList;
        });

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

          await tester.pump();

          expect(find.byKey(HomePage.errorBoxKey), findsOneWidget);

          await tester.tap(find.widgetWithText(TextButton, 'RETRY'));

          verify(() => repository.fetchAll(page: 1)).called(2);

          await tester.pump();

          final Finder lastFetchedItem = find.byKey(const Key('7'));
          await tester.scrollUntilVisible(lastFetchedItem, 500.0);

          expect(lastFetchedItem, findsOneWidget);
        });
      });

      testWidgets('can handle overscroll fetch error', (WidgetTester tester) async {
        int requestCount = 0;
        when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((_) async {
          if (requestCount == 1) {
            throw Exception('Error');
          }
          requestCount++;
          return dummyArtModelList.sublist(0, 8);
        });

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

          await tester.pump();

          final Finder overscrollBox = find.byKey(HomePage.overscrollBoxKey);
          await tester.scrollUntilVisible(overscrollBox, 500.0);

          expect(overscrollBox, findsOneWidget);

          verify(() => repository.fetchAll(page: 2)).called(1);

          expect(find.byKey(HomePage.errorBoxKey), findsOneWidget);
        });
      });

      testWidgets('can handle overscroll fetch error and retry', (WidgetTester tester) async {
        int requestCount = 0;
        when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((_) async {
          if (requestCount == 1) {
            throw Exception('Error');
          }
          requestCount++;
          return dummyArtModelList.sublist(0, 8);
        });

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

          await tester.pump();

          final Finder overscrollBox = find.byKey(HomePage.overscrollBoxKey);
          await tester.scrollUntilVisible(overscrollBox, 500.0);

          expect(overscrollBox, findsOneWidget);

          expect(find.byKey(HomePage.errorBoxKey), findsOneWidget);

          await tester.tap(find.widgetWithText(TextButton, 'RETRY'));

          verify(() => repository.fetchAll(page: 2)).called(2);
        });
      });

      testWidgets('can handle overscroll fetch error, retry and continue', (WidgetTester tester) async {
        int requestCount = 0;
        when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((Invocation inv) async {
          final int page = inv.namedArguments[const Symbol('page')] as int;
          if (requestCount == 1) {
            requestCount++;
            throw Exception('Error');
          }
          requestCount++;
          const int perPage = 8;
          return dummyArtModelList.sublist((page - 1) * perPage, page * perPage);
        });

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeApp(home: const HomePage(), repository: repository));

          await tester.pump();

          final Finder overscrollBox = find.byKey(HomePage.overscrollBoxKey);
          await tester.scrollUntilVisible(overscrollBox, 500.0);

          expect(overscrollBox, findsOneWidget);

          expect(find.byKey(HomePage.errorBoxKey), findsOneWidget);

          await tester.tap(find.widgetWithText(TextButton, 'RETRY'));

          verify(() => repository.fetchAll(page: 2)).called(2);

          await tester.pump();

          final Finder lastFetchedItem = find.byKey(const Key('15'));
          await tester.scrollUntilVisible(lastFetchedItem, 500.0);

          expect(lastFetchedItem, findsOneWidget);
        });
      });
    });
  });
}
