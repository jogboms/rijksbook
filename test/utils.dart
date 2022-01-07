import 'package:flutter/widgets.dart';
import 'package:rijksbook/app.dart';
import 'package:rijksbook/domain.dart';

import 'mocks.dart';

Widget makeApp({Widget? home, RijksRepository? repository}) =>
    App(home: home, repository: repository ?? MockRijksRepository());
