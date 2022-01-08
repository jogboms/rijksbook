import 'package:clock/clock.dart';
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

      test('ArtImageExtension.aspectRatio', () {
        expect(const ArtImage(guid: '', url: '', width: 2, height: 4).aspectRatio, .5);
        expect(const ArtImage(guid: '', url: '', width: 4, height: 2).aspectRatio, 2);
      });

      test('ArtColorExtension.hexAsInt', () {
        expect(const ArtColor(percentage: 0, hex: '000000').hexAsInt, 4278190080);
        expect(const ArtColor(percentage: 0, hex: '#000000').hexAsInt, 4278190080);
        expect(const ArtColor(percentage: 0, hex: '#999999').hexAsInt, 4288256409);
        expect(const ArtColor(percentage: 0, hex: '#ffffff').hexAsInt, 4294967295);
      });

      test('ArtMakerExtension.initials', () {
        final ArtMaker maker = ArtMaker(
          name: '',
          unFixedName: '',
          dateOfBirth: clock.now(),
          biography: '',
          roles: const <String>[],
          labelDesc: '',
          occupation: const <String>[],
        );
        expect(maker.copyWith(unFixedName: 'Jong, Luuk van de').initials, 'J.L');
        expect(maker.copyWith(unFixedName: 'Willson, Paul Monk Bailey').initials, 'W.P');
      });
    });
  });
}
