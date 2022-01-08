import 'package:flutter/material.dart';
import 'package:rijksbook/domain.dart';

class ArtColorRow extends StatelessWidget {
  const ArtColorRow({Key? key, required this.colors, this.size = 24}) : super(key: key);

  final List<ArtColor> colors;
  final double size;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 4,
        children: <Widget>[
          for (final ArtColor item in colors)
            SizedBox.square(
              key: Key(item.hex),
              dimension: size,
              child: ColoredBox(key: Key('color-' + item.hex), color: Color(item.hexAsInt ?? 0x0)),
            ),
        ],
      );
}
