import 'package:dio/dio.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class ImageApiProvider {
  Dio _dio = Dio();

  Future<List<String?>?> getNewImage(int? page, int? limit) async {
    var response = await _dio.get(
        '${ApiConstants.newImageURL}?new=true&popular=false&page=$page&limit=$limit');

    if (response.statusCode == 200) {
      List<String?>? result = [];
      for (var i = 0; i < limit!; i++) {
        result.add(response.data['data'][i]['image']['name']);
      }
      return result;
    }
    return null;
  }
}
