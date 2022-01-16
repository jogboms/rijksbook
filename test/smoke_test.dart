import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rijksbook/screens.dart';

import 'mocks.dart';
import 'utils.dart';

void main() {
  late MockRijksRepository repository;

  setUp(() {
    repository = MockRijksRepository();
  });

  tearDown(() {
    reset(repository);
  });

  testWidgets('Smoke test', (WidgetTester tester) async {
    when(() => repository.fetchAll(page: any(named: 'page'))).thenAnswer((_) async => dummyArtModelList);
    when(() => repository.fetch(any())).thenAnswer((_) async => dummyArtDetailModel);

    await tester.pumpWidget(makeApp(repository: repository));

    expect(find.text('RijksBook'), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);

    await tester.pump();

    await tester.tap(find.byKey(const Key('0')));

    await tester.pump();
    await tester.pump();

    expect(find.byType(DetailsPage), findsOneWidget);

    await tester.pump();

    expect(find.byKey(Key(dummyArtModel.id)), findsOneWidget);

    await tester.fling(find.byType(DetailsPage), const Offset(0, 1500), 10);

    await tester.tap(find.byType(BackButton));

    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(DetailsPage), findsNothing);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
