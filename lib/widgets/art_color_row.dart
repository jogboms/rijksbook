import 'package:flutter/material.dart';
import 'package:rijksbook/domain.dart';

class ArtColorRow extends StatelessWidget {
  const ArtColorRow({Key? key, required this.colors}) : super(key: key);

  final List<ArtColor> colors;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Wrap(
      spacing: 4,
      children: <Widget>[
        for (final ArtColor item in colors)
          SizedBox.square(
            key: Key(item.hex),
            dimension: theme.iconTheme.size ?? 24,
            child: ColoredBox(color: Color(item.hexAsInt ?? 0x0)),
          ),
      ],
    );
  }
}
