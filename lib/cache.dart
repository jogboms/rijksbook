import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

abstract class Cache<K, V> {
  V? get(K id);

  V set(K id, V value);

  bool contains(K id);
}

class InMemoryCache<K, V> implements Cache<K, V> {
  InMemoryCache(this.maxEntries)
      : _queue = QueueList<K>(maxEntries),
        _cache = <K, V>{};

  final int maxEntries;
  final QueueList<K> _queue;
  final Map<K, V> _cache;

  @visibleForTesting
  List<K> get keys => _queue.toList(growable: false);

  @visibleForTesting
  List<V> get values => _cache.values.toList(growable: false);

  @visibleForTesting
  void reset() {
    _queue.clear();
    _cache.clear();
  }

  @override
  V? get(K id) {
    if (contains(id)) {
      _addToQueue(id);
      return _cache[id]!;
    }
    return null;
  }

  @override
  V set(K id, V value) {
    _tidy();
    _addToQueue(id);
    _cache[id] = value;
    return value;
  }

  @override
  bool contains(K id) => _queue.contains(id) && _cache.containsKey(id);

  void _addToQueue(K id) => _queue
    ..remove(id)
    ..addFirst(id);

  void _tidy() {
    if (_queue.length == maxEntries) {
      _cache.remove(_queue.removeLast());
    }
  }
}
