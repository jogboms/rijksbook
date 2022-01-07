import 'package:flutter/material.dart';
import 'package:rijksbook/domain.dart';

class RepositoryProvider extends InheritedWidget {
  const RepositoryProvider({Key? key, required Widget child, required this.repository}) : super(key: key, child: child);

  final RijksRepository repository;

  static RijksRepository of(BuildContext context) {
    final InheritedElement? element = context.getElementForInheritedWidgetOfExactType<RepositoryProvider>();
    assert(element != null, 'No RepositoryProvider found in context');
    return (element!.widget as RepositoryProvider).repository;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) => repository != oldWidget.repository;
}

extension RepositoryProviderExtension on BuildContext {
  RijksRepository get repository => RepositoryProvider.of(this);
}
