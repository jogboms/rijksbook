import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({Key? key, required this.url, this.builder}) : super(key: key);

  final String url;
  final Widget Function(ImageProvider<Object>)? builder;

  static const Key loadingKey = Key('loading');

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        key: Key(url),
        imageUrl: url,
        fit: BoxFit.cover,
        imageBuilder: builder != null ? (_, ImageProvider<Object> imageProvider) => builder!(imageProvider) : null,
        placeholder: (_, __) => const Center(key: loadingKey, child: CircularProgressIndicator()),
        errorWidget: (_, __, Object? ___) => const Center(child: Icon(Icons.error)),
      );
}
