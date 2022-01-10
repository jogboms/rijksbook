import 'package:flutter/widgets.dart';
import 'package:rijksbook/domain.dart';

abstract class DataController<T> with ChangeNotifier {
  DataController(this._data);

  T get data => _data;
  T _data;

  ControllerException? get error => _error;
  ControllerException? _error;

  @visibleForTesting
  ConnectionState get state => _state;
  ConnectionState _state = ConnectionState.none;

  set state(ConnectionState newState) {
    if (_state == newState) {
      return;
    }
    _state = newState;
    notifyListeners();
  }

  bool get isLoading => _state == ConnectionState.waiting;

  bool get hasError => _state == ConnectionState.done && error != null;

  Future<void> fetch();

  Future<void> retry();
}

class PagedDataController extends DataController<List<Art>> {
  PagedDataController(this._source) : super(const <Art>[]);

  final Future<List<Art>> Function({required int page}) _source;

  @visibleForTesting
  int get page => _page;
  int _page = 1;

  @override
  Future<void> fetch() async {
    const int page = 1;
    await _fetch(page, true);
    if (!hasError) {
      _page = page;
    }
  }

  Future<void> next() async {
    final int page = _page + 1;
    await _fetch(page);
    _page = page;
  }

  @override
  Future<void> retry() => _fetch(_page);

  Future<void> _fetch(int page, [bool clear = false]) async {
    state = ConnectionState.waiting;
    try {
      _data = <Art>[
        if (!clear) ...data,
        ...(await _source(page: page)),
      ].toList(growable: false);
      _error = null;
    } catch (e, stackTrace) {
      _error = ControllerException(e.toString(), stackTrace);
    }
    state = ConnectionState.done;
  }
}

class DetailDataController extends DataController<ArtDetail?> {
  DetailDataController(this._source, {required this.id}) : super(null);

  final Future<ArtDetail> Function(String id) _source;
  final String id;

  @override
  Future<void> fetch() async {
    state = ConnectionState.waiting;
    try {
      _data = await _source(id);
      _error = null;
    } catch (e, stackTrace) {
      _error = ControllerException(e.toString(), stackTrace);
    }
    state = ConnectionState.done;
  }

  @override
  Future<void> retry() => fetch();
}

class ControllerException implements Exception {
  const ControllerException(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;
}
