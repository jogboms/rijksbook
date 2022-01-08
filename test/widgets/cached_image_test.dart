import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/widgets.dart';

void main() async {
  group('CachedImage', () {
    testWidgets('works normally with url', (WidgetTester tester) async {
      const String url = '';
      const ImageProvider<Object> provider = CachedNetworkImageProvider(url);
      await tester.pumpWidget(const MaterialApp(home: CachedImage(url: url)));

      expect(find.byKey(CachedImage.loadingKey), findsOneWidget);
      expect(find.byKey(const ValueKey<ImageProvider<Object>>(provider)), findsOneWidget);
    });

    testWidgets('works normally with builder', (WidgetTester tester) async {
      const String url = 'fake_url';
      const ImageProvider<Object> provider = CachedNetworkImageProvider(url);
      await tester.pumpWidget(MaterialApp(
        home: CachedImage(url: url, builder: (_) => const SizedBox.shrink()),
      ));

      expect(find.byKey(CachedImage.loadingKey), findsOneWidget);
      expect(find.byKey(const ValueKey<ImageProvider<Object>>(provider)), findsOneWidget);
    });
  });
}
