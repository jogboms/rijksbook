import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/domain.dart';
import 'package:rijksbook/widgets.dart';

void main() async {
  group('ArtColorRow', () {
    final Map<String, int> hexColorMap = <String, int>{
      '#000000': 0xFF000000,
      '#999999': 0xFF999999,
      '#ffffff': 0xFFffffff,
      'weird': 0x0,
    };
    final Iterable<String> hexColors = hexColorMap.keys;

    testWidgets('works normally', (WidgetTester tester) async {
      final List<ArtColor> colors = hexColors.map((String hex) => ArtColor(percentage: 0, hex: hex)).toList();
      await tester.pumpWidget(MaterialApp(home: ArtColorRow(colors: colors, size: 48)));

      for (final String hex in hexColors) {
        final SizedBox sizedBox = tester.widget<SizedBox>(find.byKey(Key(hex)));
        expect(sizedBox.width, 48);
        expect(sizedBox.height, 48);

        final ColoredBox coloredBox = tester.widget<ColoredBox>(find.byKey(Key('color-$hex')));
        expect(coloredBox.color.value, hexColorMap[hex]);
      }
    });
  });
}
