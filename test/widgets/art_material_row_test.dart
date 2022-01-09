import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/widgets.dart';

void main() {
  group('ArtMaterialRow', () {
    testWidgets('works normally', (WidgetTester tester) async {
      const List<String> materials = <String>['A', 'B', 'C'];
      await tester.pumpWidget(const MaterialApp(home: Material(child: ArtMaterialRow(materials: materials))));

      for (final String material in materials) {
        expect(find.widgetWithText(Chip, material), findsOneWidget);
      }
    });

    testWidgets('removes duplicate items', (WidgetTester tester) async {
      const List<String> materials = <String>['A', 'A', 'A'];
      await tester.pumpWidget(const MaterialApp(home: Material(child: ArtMaterialRow(materials: materials))));

      expect(find.widgetWithText(Chip, 'A'), findsOneWidget);
    });
  });
}
