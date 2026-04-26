import '../entities/cat_status.dart';
import '../repositories/cat_repository.dart';

/// Fetches a cat image for a valid HTTP status code.
class GetCatByStatusCode {
  final CatRepository _repository;

  const GetCatByStatusCode(this._repository);

  Future<CatStatus> call(int statusCode) {
    return _repository.getCatByStatusCode(statusCode);
  }
}
