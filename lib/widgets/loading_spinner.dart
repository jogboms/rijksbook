import 'package:flutter/material.dart';

class LoadingSpinner extends Center {
  const LoadingSpinner({Key? key = defaultKey}) : super(key: key, child: const CircularProgressIndicator());

  static const Key defaultKey = Key('spinkit');
}
