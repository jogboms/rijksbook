import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rijksbook/domain.dart';

class ArtLinksButton extends StatelessWidget {
  ArtLinksButton({Key? key, required this.links, ArtLinksBrowser? browser})
      : browser = browser ?? _NativeBrowser(),
        super(key: key);

  final ArtLinks links;
  final ArtLinksBrowser browser;

  @override
  Widget build(BuildContext context) => links.url != null
      ? Material(
          type: MaterialType.transparency,
          child: IconButton(onPressed: () => browser.open(links.url!), icon: const Icon(Icons.link)),
        )
      : const SizedBox.shrink();
}

abstract class ArtLinksBrowser {
  void open(String url);
}

class _NativeBrowser implements ArtLinksBrowser {
  final ChromeSafariBrowser browser = ChromeSafariBrowser();

  @override
  void open(String url) => browser.open(
      url: Uri.parse(url), options: ChromeSafariBrowserClassOptions(ios: IOSSafariOptions(barCollapsingEnabled: true)));
}
