import 'package:flutter/material.dart';
import 'package:rijksbook/domain.dart';

class ArtDimensionItem extends StatelessWidget {
  const ArtDimensionItem({Key? key, required this.dimension}) : super(key: key);

  final ArtDimension dimension;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(text: '${dimension.type.toUpperCase()}: ', style: textTheme.overline),
          TextSpan(text: '${dimension.value}${dimension.unit}'),
          if (dimension.part != null) TextSpan(text: ' (${dimension.part})', style: textTheme.overline),
        ]),
        style: textTheme.bodyText1,
      ),
    );
  }
}
