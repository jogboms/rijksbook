import 'package:flutter/widgets.dart';
import 'package:rijksbook/domain.dart';

class PagedDataController with ChangeNotifier {
  PagedDataController(this.repo);

  final RijksRepository repo;

  int _page = 0;

  List<Art> get data => _data;
  List<Art> _data = List<Art>.empty(growable: true);

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

class ControllerException implements Exception {
  const ControllerException(this.message, this.stackTrace);

  final String message;
  final StackTrace stackTrace;
}
