import '../../domain/entities/cat_status.dart';

/// In-memory local store for favorite cat statuses.
///
/// This can later be replaced by SharedPreferences, Hive, or SQLite
/// without changing presentation or domain layers.
class FavoritesLocalDataSource {
  final List<CatStatus> _favorites = <CatStatus>[];

  List<CatStatus> getFavorites() {
    return List<CatStatus>.unmodifiable(_favorites);
  }

  List<CatStatus> toggleFavorite(CatStatus catStatus) {
    final index = _favorites.indexWhere(
      (item) => item.statusCode == catStatus.statusCode,
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(catStatus);
    }

    return List<CatStatus>.unmodifiable(_favorites);
  }
}
