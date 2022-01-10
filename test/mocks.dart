import 'package:mocktail/mocktail.dart';
import 'package:rijksbook/domain.dart';

class MockRijksRepository extends Mock implements RijksRepository {}

Art get dummyArtModel => _generateArtModel('id');

ArtDetail get dummyArtDetailModel => ArtDetail(
      objectNumber: 'id',
      id: 'id',
      hasImage: true,
      showImage: true,
      longTitle: 'Lorem Ipsum ' * 10,
      title: 'Lorem Ipsum',
      principalOrFirstMaker: 'Name with Lorem Ipsum',
      webImage: _dummyArtImage,
      subTitle: '',
      principalMakers: const <ArtMaker>[],
      label: ArtLabel(date: DateTime(1100)),
      plaqueDescriptionEnglish: '',
      principalMaker: '',
      materials: const <String>[],
      physicalProperties: const <String>[],
      dating: const ArtDating(
        period: 1100,
        yearEarly: 1100,
        presentingDate: 'c. 1100',
        yearLate: 1100,
        sortingDate: 1100,
      ),
      objectCollection: const <String>[],
      historicalPersons: const <String>[],
      physicalMedium: '',
      titles: const <String>[],
      colors: const <ArtColor>[],
      normalizedColors: const <ArtColor>[],
      techniques: const <String>[],
      objectTypes: const <String>[],
      scLabelLine: '',
      dimensions: const <ArtDimension>[],
      productionPlaces: const <String>[],
      documentation: const <String>[],
      description: '',
    );

List<Art> get dummyArtModelList => List<Art>.generate(20, (int index) => _generateArtModel('$index'));

Art _generateArtModel(String id, {String title = 'Lorem Ipsum'}) => Art(
      objectNumber: id,
      id: id,
      hasImage: true,
      showImage: true,
      longTitle: '$title ' * 10,
      title: title,
      principalOrFirstMaker: 'Name with Lorem Ipsum',
      headerImage: _dummyArtImage,
      webImage: _dummyArtImage,
      links: const ArtLinks(web: 'https://google.com'),
    );

ArtImage get _dummyArtImage => const ArtImage(guid: 'id', url: 'imageUrl', width: 150, height: 150);
