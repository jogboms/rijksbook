import 'package:flutter/material.dart';

import 'screens.dart';

class App extends StatefulWidget {
  const App({Key? key, this.home}) : super(key: key);

  final Widget? home;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'RijksBook',
        theme: ThemeData.dark(),
        home: widget.home ?? const HomePage(),
      );
}
