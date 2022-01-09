import 'package:flutter/material.dart';
import 'package:rijksbook/constants.dart';
import 'package:rijksbook/domain.dart';
import 'package:rijksbook/provider.dart';
import 'package:rijksbook/widgets.dart';

import 'data_controller.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.art}) : super(key: key);

  final Art art;

  static void go(BuildContext context, {required Art art}) => Navigator.of(context)
      .push<void>(MaterialPageRoute<void>(builder: (BuildContext context) => DetailsPage(art: art)));

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final DetailDataController controller =
      DetailDataController(context.repository.fetch, id: widget.art.objectNumber);

  @override
  void initState() {
    controller.fetch();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(widget.art.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              actions: <Widget>[ArtLinksButton(links: widget.art.links)],
              pinned: true,
              stretch: true,
              expandedHeight: (widget.art.headerImage?.height ?? 0) / MediaQuery.of(context).devicePixelRatio,
              flexibleSpace: FlexibleSpaceBar(
                background: widget.art.headerImage?.url != null ? CachedImage(url: widget.art.headerImage!.url!) : null,
                stretchModes: const <StretchMode>[StretchMode.zoomBackground],
                collapseMode: CollapseMode.parallax,
              ),
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                if (controller.isLoading) {
                  return const SliverFillRemaining(child: LoadingSpinner());
                }
                if (controller.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(controller.error!.message),
                          AppSpacing.v4,
                          TextButton(
                            onPressed: () => controller.fetch(retry: true),
                            child: const Text('RETRY'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final ArtDetail? data = controller.data;
                if (data == null) {
                  return const SliverFillRemaining(child: Center(child: Text('Could not find art work? :(')));
                }

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 48),
                  sliver: _DataView(key: Key(data.objectNumber), data: data),
                );
              },
            ),
          ],
        ),
      );
}

class _DataView extends StatelessWidget {
  const _DataView({Key? key, required this.data}) : super(key: key);

  final ArtDetail data;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        AppSpacing.v16,
        Text(data.longTitle, style: textTheme.headline5),
        AppSpacing.v4,
        Text(data.subTitle, style: textTheme.subtitle1),
        AppSpacing.v8,
        if (data.physicalMedium != null) ...<Widget>[
          Text(data.physicalMedium!, style: textTheme.caption?.copyWith(fontSize: 14)),
          AppSpacing.v8,
        ],
        Text(
          '# ' + <String>[...data.objectTypes, ...data.objectCollection].join(', #'),
          style: textTheme.caption?.copyWith(color: Colors.blue),
        ),
        AppSpacing.v16,
        const Divider(),
        AppSpacing.v16,
        Row(children: <Widget>[
          const Icon(Icons.format_paint, size: 20),
          AppSpacing.h2,
          Text(data.principalMaker, style: textTheme.bodyText1),
        ]),
        AppSpacing.v10,
        Text(
          data.label.description ?? data.plaqueDescriptionEnglish ?? data.description ?? 'N/A',
          style: textTheme.bodyText1?.copyWith(height: 1.5),
        ),
        AppSpacing.v16,
        Text(data.scLabelLine, style: textTheme.caption),
        if (data.webImage?.url != null) ...<Widget>[
          AppSpacing.v4,
          AspectRatio(aspectRatio: data.webImage!.aspectRatio, child: CachedImage(url: data.webImage!.url!)),
          AppSpacing.v4,
        ],
        ArtColorRow(colors: data.normalizedColors),
        AppSpacing.v2,
        ArtMaterialRow(materials: data.materials),
        AppSpacing.v16,
        const Divider(),
        AppSpacing.v16,
        if (data.dimensions.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Dimensions'),
          AppSpacing.v8,
          for (final ArtDimension dimension in data.dimensions)
            ArtDimensionItem(key: Key(dimension.toString()), dimension: dimension),
          AppSpacing.v12,
        ],
        const _SectionHeaderText('Principal makers'),
        AppSpacing.v8,
        for (final ArtMaker maker in data.principalMakers) ArtMakerItem(key: Key(maker.name), maker: maker),
        AppSpacing.v12,
        if (data.productionPlaces.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Production places'),
          AppSpacing.v8,
          Text(data.productionPlaces.join(', '), style: textTheme.bodyText2),
          AppSpacing.v12,
        ],
        if (data.techniques.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Techniques'),
          AppSpacing.v8,
          Text(data.techniques.join(', '), style: textTheme.bodyText2),
          AppSpacing.v12,
        ],
        if (data.physicalProperties.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Physical properties'),
          AppSpacing.v8,
          Text(data.physicalProperties.join(', '), style: textTheme.bodyText2),
          AppSpacing.v12,
        ],
        if (data.historicalPersons.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Historical persons'),
          AppSpacing.v8,
          Text(data.historicalPersons.join(', '), style: textTheme.bodyText2),
          AppSpacing.v12,
        ],
        if (data.documentation.isNotEmpty) ...<Widget>[
          const _SectionHeaderText('Documentation'),
          AppSpacing.v8,
          Text('— ' + data.documentation.join('\n— '), style: textTheme.bodyText2?.copyWith(height: 1.25)),
          AppSpacing.v12,
        ],
        AppSpacing.v24,
      ]),
    );
  }
}

class _SectionHeaderText extends StatelessWidget {
  const _SectionHeaderText(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      data,
      style: textTheme.subtitle1?.copyWith(
        letterSpacing: .85,
        height: 1.5,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.double,
        decorationColor: textTheme.caption?.color,
        color: textTheme.caption?.color,
      ),
      key: Key(data),
    );
  }
}
