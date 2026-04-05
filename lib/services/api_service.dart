import '../models/cat.dart';

class ApiService {
  Future<Cat> fetchCat(int code) async {
    await Future.delayed(const Duration(seconds: 1));

    if (code < 100 || code > 599) {
      throw Exception("Invalid status code");
    }

    return Cat.fromCode(code);
  }
}
