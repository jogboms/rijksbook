import 'package:flutter/material.dart';
import 'package:rijksbook/app.dart';
import 'package:rijksbook/domain.dart';

import 'mocks.dart';

Widget makeApp({Widget? home, RijksRepository? repository}) =>
    App(home: home, repository: repository ?? MockRijksRepository());

Art get dummyArtModel {
  const int imageSize = 150;
  const String imageUrl = 'https://via.placeholder.com/$imageSize';
  return Art(
    objectNumber: 'id',
    id: 'id',
    hasImage: true,
    showImage: true,
    longTitle: 'Lorem Ipsum ' * 10,
    title: 'Lorem Ipsum ' * 5,
    principalOrFirstMaker: 'Lorem Ipsum',
    headerImage: ArtImage(guid: 'id', url: imageUrl, width: imageSize, height: imageSize),
    webImage: ArtImage(guid: 'id', url: imageUrl, width: imageSize, height: imageSize),
    url: 'https://google.com',
  );
}
