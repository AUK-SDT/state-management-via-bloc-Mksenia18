import '../entities/cat_status.dart';
import '../repositories/cat_repository.dart';

/// Adds a cat status to favorites if missing, or removes it if already saved.
class ToggleFavoriteCat {
  final CatRepository _repository;

  const ToggleFavoriteCat(this._repository);

  Future<List<CatStatus>> call(CatStatus catStatus) {
    return _repository.toggleFavorite(catStatus);
  }
}
