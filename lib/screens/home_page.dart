import 'package:flutter/material.dart';
import 'package:rijksbook/constants.dart';
import 'package:rijksbook/domain.dart';
import 'package:rijksbook/provider.dart';
import 'package:rijksbook/widgets.dart';

import 'data_controller.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @visibleForTesting
  static const Key overscrollBoxKey = Key('overscroll-box');
  @visibleForTesting
  static const Key errorBoxKey = Key('error-box');
  @visibleForTesting
  static const Key emptyStateKey = Key('empty-state');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PagedDataController controller = PagedDataController(context.repository.fetchAll);

  final ValueNotifier<bool> singleColumn = ValueNotifier<bool>(false);

  late final Listenable combinedViewModel = Listenable.merge(<Listenable>[controller, singleColumn]);

  static const double overScrollOffset = 100;

  LoadingStatus _loadingStatus = LoadingStatus.initial;

  @override
  void initState() {
    controller.fetch().then(_onFinishedRequest);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    singleColumn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: const Text(appName),
                pinned: true,
                actions: <Widget>[
                  ValueListenableBuilder<bool>(
                    valueListenable: singleColumn,
                    builder: (_, bool value, __) => IconButton(
                      onPressed: () => singleColumn.value = !value,
                      icon: Icon(value ? Icons.looks_one : Icons.looks_two),
                    ),
                  )
                ],
              ),
              AnimatedBuilder(
                animation: combinedViewModel,
                builder: (BuildContext context, _) {
                  if (_loadingStatus == LoadingStatus.initial) {
                    if (controller.isLoading) {
                      return const SliverFillRemaining(child: LoadingSpinner());
                    }
                    if (controller.hasError) {
                      return SliverFillRemaining(
                        child: Center(
                          key: HomePage.errorBoxKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(controller.error!.message),
                              AppSpacing.v4,
                              TextButton(onPressed: _onRetry, child: const Text('RETRY')),
                            ],
                          ),
                        ),
                      );
                    }
                  }

                  final List<Art> items = controller.data;
                  if (items.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(key: HomePage.emptyStateKey, child: Text('Could not find any art works? :(')),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: singleColumn.value ? 1 : 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final Art art = items[index];
                          return ArtGridItem(
                            key: ValueKey<String>(art.id),
                            art: art,
                            onPressed: () => DetailsPage.go(context, art: art),
                          );
                        },
                        childCount: items.length,
                      ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                key: HomePage.overscrollBoxKey,
                child: AnimatedBuilder(
                  animation: controller,
                  child: const SizedBox(height: overScrollOffset / 3),
                  builder: (BuildContext context, Widget? child) {
                    if (_loadingStatus == LoadingStatus.initial || !(controller.isLoading || controller.hasError)) {
                      return child!;
                    }

                    child = controller.isLoading
                        ? const LoadingSpinner()
                        : controller.hasError
                            ? Padding(
                                key: HomePage.errorBoxKey,
                                padding: const EdgeInsets.all(8),
                                child: Row(children: <Widget>[
                                  Expanded(child: Text(controller.error!.message)),
                                  AppSpacing.h4,
                                  TextButton(onPressed: _onRetry, child: const Text('RETRY')),
                                ]),
                              )
                            : null;
                    return SafeArea(top: false, child: SizedBox(height: kToolbarHeight, child: Material(child: child)));
                  },
                ),
              ),
            ],
          ),
        ),
      );

  void _onRetry() => controller.retry().then(_onFinishedRequest);

  void _onLoadMore() => controller.next().then((_) => _loadingStatus = LoadingStatus.idle);

  void _onFinishedRequest(void _) {
    if (!controller.hasError) {
      _loadingStatus = LoadingStatus.idle;
    }
  }

  void _onOverscroll() {
    if (_loadingStatus == LoadingStatus.idle) {
      _loadingStatus = LoadingStatus.loading;
      _onLoadMore();
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (Axis.vertical == notification.metrics.axis) {
      if (notification is ScrollUpdateNotification) {
        if (notification.metrics.pixels > notification.metrics.maxScrollExtent &&
            notification.metrics.pixels - notification.metrics.maxScrollExtent >= overScrollOffset) {
          _onOverscroll();
        }
        return true;
      }

      if (notification is OverscrollNotification) {
        if (notification.overscroll > 0) {
          _onOverscroll();
        }
        return true;
      }
    }
    return false;
  }
}

enum LoadingStatus { idle, initial, loading }
