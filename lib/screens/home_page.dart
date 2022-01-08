import 'package:flutter/material.dart';
import 'package:rijksbook/constants.dart';
import 'package:rijksbook/domain.dart';
import 'package:rijksbook/provider.dart';
import 'package:rijksbook/widgets.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final RijksRepository repo = context.repository;
  late final Future<List<Art>> _future = repo.fetchAll(page: 1);

  static const double overScrollOffset = 100;

  LoadingStatus _loadingStatus = LoadingStatus.initial;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(title: Text(appName), pinned: true),
              FutureBuilder<List<Art>>(
                future: _future,
                builder: (BuildContext context, AsyncSnapshot<List<Art>> snapshot) {
                  final List<Art>? items = snapshot.data;
                  if (items == null) {
                    return const SliverToBoxAdapter(child: LoadingSpinner());
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
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
            ],
          ),
        ),
      );

  void _onLoadMore() async {
    _loadingStatus = LoadingStatus.idle;
  }

  void _onOverscroll() {
    if (_loadingStatus != LoadingStatus.loading) {
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
