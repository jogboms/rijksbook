import 'package:flutter/widgets.dart';
import 'package:rijksbook/domain.dart';

abstract class DataController<T> with ChangeNotifier {
  DataController(this._data);

  T get data => _data;
  T _data;

  ControllerException? get error => _error;
  ControllerException? _error;

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

  Future<void> fetch({bool retry = false});
}

class PagedDataController extends DataController<List<Art>> {
  PagedDataController(this.repo) : super(List<Art>.empty(growable: true));

  final RijksRepository repo;

  int _page = 0;

  @override
  Future<void> fetch({bool retry = false}) async {
    state = ConnectionState.waiting;
    try {
      final int page = retry ? _page : _page + 1;
      final List<Art> items = await repo.fetchAll(page: _page);
      _data = data..addAll(items);
      _page = page;
      _error = null;
      state = ConnectionState.done;
    } catch (e, stackTrace) {
      _error = ControllerException(e.toString(), stackTrace);
      state = ConnectionState.done;
    }
  }
}

class DetailDataController extends DataController<ArtDetail?> {
  DetailDataController(this.repo, {required this.id}) : super(null);

  final RijksRepository repo;
  final String id;

  @override
  Future<void> fetch({bool retry = false}) async {
    state = ConnectionState.waiting;
    try {
      _data = await repo.fetch(id);
      _error = null;
      state = ConnectionState.done;
    } catch (e, stackTrace) {
      _error = ControllerException(e.toString(), stackTrace);
      state = ConnectionState.done;
    }
  }
}

class ControllerException implements Exception {
  const ControllerException(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;
}
