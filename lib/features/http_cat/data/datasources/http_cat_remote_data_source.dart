import 'package:http/http.dart' as http;

import '../models/cat_status_model.dart';

/// Works with the public HTTP Cat API.
class HttpCatRemoteDataSource {
  static const _baseUrl = 'https://http.cat';

  Future<CatStatusModel> fetchCatByStatusCode(int statusCode) async {
    if (statusCode < 100 || statusCode > 599) {
      throw Exception('Status code must be between 100 and 599.');
    }

    final uri = Uri.parse('$_baseUrl/$statusCode');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('No cat image found for status $statusCode.');
    }

    return CatStatusModel.fromStatusCode(statusCode);
  }
}
