import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/domain.dart';

void main() {
  group('Models', () {
    group('Parsers', () {
      test('stringToDoubleParser', () {
        expect(stringToDoubleParser('1.0'), 1.0);
        expect(stringToDoubleParser('-1.0'), -1.0);
        expect(stringToDoubleParser('0.0'), 0.0);
        expect(stringToDoubleParser('1'), 1.0);
        expect(stringToDoubleParser(''), 0.0);
        expect(stringToDoubleParser('aba'), 0.0);
      });

      test('stringToDateParser', () {
        expect(stringToDateParser(''), DateTime(0));
        expect(stringToDateParser('c. 1454'), DateTime(1454));
        expect(stringToDateParser('1454'), DateTime(1454));
        expect(stringToDateParser('1454-14'), DateTime(1454, 14));
        expect(stringToDateParser('1454-14-12'), DateTime(1454, 14, 12));
      });

      test('stringToDateParser', () {
        expect(stringToDateNullableParser(), isNull);
        expect(stringToDateNullableParser(null), isNull);
        expect(stringToDateNullableParser(''), DateTime(0));
        expect(stringToDateNullableParser('c. 1454'), DateTime(1454));
        expect(stringToDateNullableParser('1454'), DateTime(1454));
        expect(stringToDateNullableParser('1454-14'), DateTime(1454, 14));
        expect(stringToDateNullableParser('1454-14-12'), DateTime(1454, 14, 12));
      });

      test('ListExtension.elementAtOrNull', () {
        expect(<int>[].elementAtOrNull(0), isNull);
        expect(<int>[1, 2].elementAtOrNull(1), 2);
      });
    });
  });
}
