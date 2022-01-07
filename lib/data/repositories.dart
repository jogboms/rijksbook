import 'package:rijksbook/domain.dart';

class DummyRijksRepository implements RijksRepository {
  @override
  Future<ArtDetail> fetch(String objectNumber) {
    // TODO: implement fetch
    throw UnimplementedError();
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
