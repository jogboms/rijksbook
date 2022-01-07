import 'package:flutter/material.dart';
import 'package:rijksbook/domain.dart';
import 'package:rijksbook/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.art}) : super(key: key);

  final Art art;

  static void go(BuildContext context, {required Art art}) => Navigator.of(context)
      .push<void>(MaterialPageRoute<void>(builder: (BuildContext context) => DetailsPage(art: art)));

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final RijksRepository repo = context.repository;
  late final Future<ArtDetail> _future = repo.fetch(widget.art.objectNumber);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(title: Text(widget.art.title, maxLines: 2), pinned: true),
            FutureBuilder<ArtDetail>(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<ArtDetail> snapshot) {
                final ArtDetail? data = snapshot.data;
                if (data == null) {
                  return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                }

                return SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    Text(data.toString()),
                  ]),
                );
              },
            ),
          ],
        ),
      );
}
