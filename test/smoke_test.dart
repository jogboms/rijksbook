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
    await tester.pumpWidget(makeApp(repository: repository));

    expect(find.text('RijksBook'), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
