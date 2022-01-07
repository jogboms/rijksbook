import 'package:rijksbook/domain.dart';

class DummyRijksRepository implements RijksRepository {
  @override
  Future<ArtDetail> fetch(String objectNumber) async {
    const int imageSize = 150;
    return ArtDetail(
      id: objectNumber,
      objectNumber: objectNumber,
      colors: <ArtColor>[
        ArtColor(percentage: 80, hex: '009688'),
        ArtColor(percentage: 10, hex: '00a688'),
        ArtColor(percentage: 10, hex: '00b688')
      ],
      title: 'Lorem Ipsum ' * 5,
      titles: <String>['Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 10],
      longTitle: 'Lorem Ipsum ' * 10,
      subTitle: 'Lorem Ipsum ' * 8,
      scLabelLine: 'Lorem Ipsum ' * 5,
      label: ArtLabel(
        title: 'Lorem Ipsum ' * 2,
        description: 'Lorem Ipsum ' * 5,
        date: DateTime.now(),
        notes: 'Lorem Ipsum ' * 5,
        makerLine: 'Lorem Ipsum ' * 5,
      ),
      description: 'Lorem Ipsum ' * 15,
      principalMaker: 'Jeremiah Ogbomo',
      principalOrFirstMaker: 'Jeremiah Ogbomo',
      principalMakers: <ArtMaker>[
        ArtMaker(
          name: 'Rijk van Gupta',
          bio: 'Lorem Ipsum ' * 5,
          unFixedName: 'Gupta, Rijk van',
          placeOfBirth: 'India',
          dateOfBirth: DateTime.now(),
          placeOfDeath: 'Amsterdam',
          dateOfDeath: DateTime.now(),
          labelDesc: 'Lorem Ipsum ' * 2,
          nationality: 'Indian',
          occupation: <String>['Lorem Ipsum 1', 'Lorem Ipsum 2'],
          roles: <String>['Lorem Ipsum 1', 'Lorem Ipsum 2'],
        ),
      ],
      plaqueDescriptionEnglish: 'Lorem Ipsum ' * 5,
      materials: <String>['oil', 'canvas'],
      productionPlaces: <String>['Amsterdam'],
      hasImage: true,
      showImage: true,
      historicalPersons: <String>['Jeremiah'],
      documentation: <String>['Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 5],
      dimensions: <ArtDimension>[
        ArtDimension(unit: 'cm', type: 'height', value: 234),
        ArtDimension(unit: 'cm', type: 'width', value: 200),
        ArtDimension(unit: 'kg', type: 'weight', value: 10),
      ],
      physicalMedium: 'oil on canvas',
      dating: ArtDating(presentingDate: 1100, sortingDate: 1100, period: 12, yearEarly: 1100, yearLate: 1100),
      objectCollection: <String>['Lorem Ipsum ' * 2, 'Lorem Ipsum ' * 2],
      objectTypes: <String>['Lorem Ipsum ' * 2, 'Lorem Ipsum ' * 2],
      webImage: ArtImage(
        guid: 'id',
        url: 'https://via.placeholder.com/$imageSize/009688/ffffff?text= ',
        width: imageSize,
        height: imageSize,
      ),
    );
  }

  @override
  Future<List<Art>> fetchAll({required int page}) async {
    final List<String> colors = <String>['4DB6AC', '26A69A', '009688', '00897B', '00695C'];
    return List<Art>.generate(20, (int index) {
      const int imageSize = 150;
      final String backgroundColor = colors[(index % colors.length)];
      final String imageUrl = 'https://via.placeholder.com/$imageSize/$backgroundColor/ffffff?text= ';
      return Art(
        objectNumber: '$index',
        id: '$index',
        hasImage: true,
        showImage: true,
        longTitle: 'Lorem Ipsum ' * 10,
        title: 'Lorem Ipsum ' * 5,
        principalOrFirstMaker: 'Lorem Ipsum',
        headerImage: ArtImage(guid: '$index', url: imageUrl, width: imageSize, height: imageSize),
        webImage: ArtImage(guid: '$index', url: imageUrl, width: imageSize, height: imageSize),
        url: 'https://google.com',
      );
    });
  }
}
