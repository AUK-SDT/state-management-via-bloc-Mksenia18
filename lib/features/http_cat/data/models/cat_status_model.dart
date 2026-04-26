import '../../domain/entities/cat_status.dart';

/// Data-transfer model for cat status payloads.
class CatStatusModel extends CatStatus {
  const CatStatusModel({required super.statusCode, required super.imageUrl});

  factory CatStatusModel.fromStatusCode(int statusCode) {
    return CatStatusModel(
      statusCode: statusCode,
      imageUrl: 'https://http.cat/$statusCode',
    );
  }
}
