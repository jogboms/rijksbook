import 'package:flutter/material.dart';

import 'cached_image.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const CloseButton()),
        body: InteractiveViewer(constrained: false, child: CachedImage(key: Key('dialog-$url'), url: url)),
      );
}
