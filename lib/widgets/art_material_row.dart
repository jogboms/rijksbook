import 'package:flutter/material.dart';

class ArtMaterialRow extends StatelessWidget {
  const ArtMaterialRow({Key? key, required this.materials}) : super(key: key);

  final List<String> materials;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Wrap(
      spacing: 4,
      children: <Widget>[
        for (final String material in materials)
          Chip(key: Key(material), label: Text(material), labelStyle: textTheme.caption),
      ],
    );
  }
}
