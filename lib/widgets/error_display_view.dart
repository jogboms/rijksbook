import 'package:flutter/material.dart';
import 'package:rijksbook/constants.dart';

class ErrorDisplayView extends StatelessWidget {
  const ErrorDisplayView({Key? key, required this.message, required this.onRetry, this.direction = Axis.vertical})
      : super(key: key);

  final String message;
  final VoidCallback onRetry;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final Widget textWidget = Text(message);
    return Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (direction == Axis.horizontal) Expanded(child: textWidget) else textWidget,
        if (direction == Axis.horizontal) AppSpacing.h4 else AppSpacing.v4,
        TextButton(onPressed: onRetry, child: const Text('RETRY')),
      ],
    );
  }
}
