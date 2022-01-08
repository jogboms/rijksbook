import 'package:flutter_test/flutter_test.dart';
import 'package:rijksbook/cache.dart';

void main() {
  group('InMemoryCache', () {
    final InMemoryCache<String, int> cache = InMemoryCache<String, int>(3);

    tearDown(() {
      cache.reset();
    });

    test('can set values', () {
      cache.set('A', 1);
      cache.set('B', 2);
      expect(cache.keys, containsAllInOrder(<String>['B', 'A']));
      expect(cache.values, hasLength(2));
    });

    test('can get values', () {
      cache.set('A', 1);
      expect(cache.get('A'), 1);
      expect(cache.get('B'), isNull);
    });

    test('can replace same id', () {
      cache.set('A', 1);
      cache.set('A', 2);
      expect(cache.keys, hasLength(1));
      expect(cache.values, hasLength(1));
      expect(cache.get('A'), 2);
    });

    test('can check availability', () {
      expect(cache.contains('A'), false);
      cache.set('A', 1);
      expect(cache.contains('A'), true);
    });

    test('should maintain LIFO', () {
      cache.set('A', 1);
      cache.set('B', 1);
      cache.set('C', 1);
      cache.set('D', 1);
      expect(cache.keys, hasLength(3));
      expect(cache.values, hasLength(3));
      expect(cache.keys, containsAllInOrder(<String>['D', 'C', 'B']));
    });

    test('should not exceed max', () {
      cache.set('A', 1);
      cache.set('B', 1);
      cache.set('C', 1);
      cache.set('D', 1);
      expect(cache.keys, hasLength(3));
      expect(cache.values, hasLength(3));
    });
  });
}
