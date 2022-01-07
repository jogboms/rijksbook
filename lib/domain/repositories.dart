import './models.dart';

abstract class RijksRepository {
  Future<ArtDetail> fetch(String objectNumber);

  Future<List<Art>> fetchAll({required int page});
}
