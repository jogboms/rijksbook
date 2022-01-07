import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'RijksBook',
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(title: const Text('RijksBook')),
          body: const Center(child: Text('Hello world')),
        ),
      );
}
