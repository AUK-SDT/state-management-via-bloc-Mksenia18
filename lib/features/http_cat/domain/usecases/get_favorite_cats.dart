import '../entities/cat_status.dart';
import '../repositories/cat_repository.dart';

/// Returns all currently saved favorite cat statuses.
class GetFavoriteCats {
  final CatRepository _repository;

  const GetFavoriteCats(this._repository);

  Future<List<CatStatus>> call() {
    return _repository.getFavoriteCats();
  }
}
