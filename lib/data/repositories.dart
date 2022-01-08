import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:http/http.dart';
import 'package:rijksbook/cache.dart';
import 'package:rijksbook/domain.dart';

class HttpRijksRepository implements RijksRepository {
  HttpRijksRepository(this.client, {required this.apiKey});

  final Client client;
  final String apiKey;
  final Cache<String, ArtDetail> cache = InMemoryCache<String, ArtDetail>(itemsPerPage);

  static String baseUrl = 'https://www.rijksmuseum.nl/api/en/collection';
  static int itemsPerPage = 30;

  @override
  Future<ArtDetail> fetch(String objectNumber) async {
    try {
      if (cache.contains(objectNumber)) {
        return cache.get(objectNumber)!;
      }
      final Response response = await client.get(Uri.parse('$baseUrl/$objectNumber?key=$apiKey'));
      final dynamic data = json.decode(response.body);
      return cache.set(objectNumber, ArtDetail.fromJson(data['artObject'] as Map<String, dynamic>));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Art>> fetchAll({required int page}) async {
    try {
      final Response response = await client.get(Uri.parse('$baseUrl?key=$apiKey&ps=$itemsPerPage&p=$page'));
      final dynamic data = json.decode(response.body);
      return <Art>[
        for (final Map<String, dynamic> item in data['artObjects']) Art.fromJson(item),
      ];
    } catch (e) {
      rethrow;
    }
  }
}

class DummyRijksRepository implements RijksRepository {
  @override
  Future<ArtDetail> fetch(String objectNumber) async {
    const int imageSize = 150;
    final List<ArtColor> colors = <ArtColor>[
      const ArtColor(percentage: 80, hex: '009688'),
      const ArtColor(percentage: 10, hex: '00a688'),
      const ArtColor(percentage: 10, hex: '00b688')
    ];
    return ArtDetail(
      id: objectNumber,
      objectNumber: objectNumber,
      colors: colors,
      normalizedColors: colors,
      title: 'Lorem Ipsum ' * 5,
      titles: <String>['Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 10],
      longTitle: 'Lorem Ipsum ' * 10,
      subTitle: 'Lorem Ipsum ' * 8,
      scLabelLine: 'Lorem Ipsum ' * 5,
      label: ArtLabel(
        title: 'Lorem Ipsum ' * 2,
        description: 'Lorem Ipsum ' * 5,
        date: clock.now(),
        notes: 'Lorem Ipsum ' * 5,
        makerLine: 'Lorem Ipsum ' * 5,
      ),
      description: 'Lorem Ipsum ' * 15,
      principalMaker: 'Jeremiah Ogbomo',
      principalOrFirstMaker: 'Jeremiah Ogbomo',
      principalMakers: <ArtMaker>[
        ArtMaker(
          name: 'Rijk van Gupta',
          biography: 'Lorem Ipsum ' * 5,
          unFixedName: 'Gupta, Rijk van',
          placeOfBirth: 'India',
          dateOfBirth: clock.now(),
          placeOfDeath: 'Amsterdam',
          dateOfDeath: clock.now(),
          labelDesc: 'Lorem Ipsum ' * 2,
          nationality: 'Indian',
          occupation: <String>['Lorem Ipsum 1', 'Lorem Ipsum 2'],
          roles: <String>['Lorem Ipsum 1', 'Lorem Ipsum 2'],
        ),
      ],
      plaqueDescriptionEnglish: 'Lorem Ipsum ' * 5,
      materials: <String>['oil', 'canvas'],
      techniques: <String>['painting'],
      physicalProperties: <String>['canvas'],
      productionPlaces: <String>['Amsterdam'],
      hasImage: true,
      showImage: true,
      historicalPersons: <String>['Jeremiah'],
      documentation: <String>['Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 5, 'Lorem Ipsum ' * 5],
      dimensions: <ArtDimension>[
        const ArtDimension(unit: 'cm', type: 'height', value: 234),
        const ArtDimension(unit: 'cm', type: 'width', value: 200),
        const ArtDimension(unit: 'kg', type: 'weight', value: 10),
      ],
      physicalMedium: 'oil on canvas',
      dating:
          const ArtDating(presentingDate: 'c. 1100', sortingDate: 1100, period: 12, yearEarly: 1100, yearLate: 1100),
      objectCollection: <String>['Lorem Ipsum ' * 2, 'Lorem Ipsum ' * 2],
      objectTypes: <String>['Lorem Ipsum ' * 2, 'Lorem Ipsum ' * 2],
      webImage: const ArtImage(
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
        links: const ArtLinks(web: 'https://google.com'),
      );
    });
  }
}
