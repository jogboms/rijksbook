import 'package:flutter/material.dart';

import 'constants.dart';
import 'domain.dart';
import 'provider.dart';
import 'screens.dart';

class App extends StatefulWidget {
  const App({Key? key, required this.repository, this.home}) : super(key: key);

  final RijksRepository repository;
  final Widget? home;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => RepositoryProvider(
        repository: widget.repository,
        child: MaterialApp(
          title: appName,
          theme: ThemeData.dark(),
          home: widget.home ?? const HomePage(),
        ),
      );
}
