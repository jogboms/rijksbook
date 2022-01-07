import 'package:mocktail/mocktail.dart';
import 'package:rijksbook/domain.dart';

class MockRijksRepository extends Mock implements RijksRepository {}

Art get dummyArtModel => generateArtModel('id');

List<Art> get dummyArtModelList => List<Art>.generate(20, (int index) => generateArtModel('$index'));

Art generateArtModel(String id, {String title = 'Lorem Ipsum'}) => Art(
      objectNumber: id,
      id: id,
      hasImage: true,
      showImage: true,
      longTitle: '$title ' * 10,
      title: '$title ' * 5,
      principalOrFirstMaker: 'Lorem Ipsum',
      headerImage: _dummyArtImage,
      webImage: _dummyArtImage,
      url: 'https://google.com',
    );

ArtImage get _dummyArtImage => ArtImage(guid: 'id', url: 'imageUrl', width: 150, height: 150);
