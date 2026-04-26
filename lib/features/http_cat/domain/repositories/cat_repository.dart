import '../entities/cat_status.dart';

/// Repository contract for all cat-related operations used by the domain layer.
abstract class CatRepository {
  Future<CatStatus> getCatByStatusCode(int statusCode);
  Future<List<CatStatus>> getFavoriteCats();
  Future<List<CatStatus>> toggleFavorite(CatStatus catStatus);
}
