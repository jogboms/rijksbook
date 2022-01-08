import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:rijksbook/screens.dart';

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

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pump();

        expect(find.byKey(Key(dummyArtModel.id)), findsOneWidget);
      });
    });
  });
}
