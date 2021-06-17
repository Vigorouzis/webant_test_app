import 'package:dio/dio.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class ImageApiProvider {
  Dio _dio = Dio();
  List<String?>? _newImages = [];
  List<String?>? _popularImages = [];

  Future<List<String?>?> getNewImage(
      int? page, int? limit, bool? isRefresh) async {
    var response = await _dio.get(
        '${ApiConstants.imageURL}?new=true&popular=false&page=$page&limit=$limit');

    if (response.statusCode == 200) {
      if (isRefresh == true) {
        clearNewData();
      }

      for (var i = 0; i < limit!; i++) {
        _newImages?.add(response.data['data'][i]['image']['name']);
      }
      return _newImages;
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<List<String?>?> getPopularImage(
      int? page, int? limit, bool? isRefresh) async {
    var response = await _dio.get(
        '${ApiConstants.imageURL}?new=false&popular=true&page=$page&limit=$limit');

    if (response.statusCode == 200) {
      if (isRefresh == true) {
        clearPopularData();
      }

      for (var i = 0; i < limit!; i++) {
        _popularImages?.add(response.data['data'][i]['image']['name']);
      }
      return _popularImages;
    } else {
      throw Exception('Failed to load images');
    }
  }

  void clearNewData() {
    _newImages?.clear();
  }

  void clearPopularData() {
    _popularImages?.clear();
  }

  Future<int?>? getNewCountOfPages() async {
    var response = await _dio
        .get('${ApiConstants.imageURL}?new=true&popular=false&&limit=10');
    return response.data['countOfPages'];
  }

  Future<int?>? getPopularCountOfPages() async {
    var response = await _dio
        .get('${ApiConstants.imageURL}?new=false&popular=true&&limit=10');
    return response.data['countOfPages'];
  }
}