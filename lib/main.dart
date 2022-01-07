import 'package:flutter/widgets.dart';
import 'package:rijksbook/data.dart';

import 'app.dart';

void main() {
  runApp(App(
    repository: DummyRijksRepository(),
  ));
}
