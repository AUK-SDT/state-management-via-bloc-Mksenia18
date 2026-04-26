import '../../domain/entities/cat_status.dart';
import '../../domain/repositories/cat_repository.dart';
import '../datasources/favorites_local_data_source.dart';
import '../datasources/http_cat_remote_data_source.dart';

/// Default repository implementation that combines remote API and local storage.
class CatRepositoryImpl implements CatRepository {
  final HttpCatRemoteDataSource _remoteDataSource;
  final FavoritesLocalDataSource _favoritesLocalDataSource;

  const CatRepositoryImpl(
    this._remoteDataSource,
    this._favoritesLocalDataSource,
  );

  @override
  Future<CatStatus> getCatByStatusCode(int statusCode) {
    return _remoteDataSource.fetchCatByStatusCode(statusCode);
  }

  @override
  Future<List<CatStatus>> getFavoriteCats() async {
    return _favoritesLocalDataSource.getFavorites();
  }

  @override
  Future<List<CatStatus>> toggleFavorite(CatStatus catStatus) async {
    return _favoritesLocalDataSource.toggleFavorite(catStatus);
  }
}
