import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import 'app.dart';
import 'data.dart';

const bool _isDemoMode = bool.fromEnvironment('demo-mode', defaultValue: false);

void main() {
  runApp(App(
    repository: _isDemoMode ? DummyRijksRepository() : HttpRijksRepository(Client(), apiKey: '3F7QLaDM'),
  ));
}
