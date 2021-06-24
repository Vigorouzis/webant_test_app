import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:webant_test_app/locator.dart';
import 'package:webant_test_app/models/image.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class ImageApiProvider {
  var _dio = locator.get<Dio>();
  List<ImageModel?>? _newImages = [];
  List<ImageModel?>? _popularImages = [];

  Future<List<ImageModel?>?> getNewImage(
      int? page, int? limit, bool? isRefresh, bool? isTabChanged) async {
    var response = await _dio.get(
        '${ApiConstants.imageURL}?new=true&popular=false&page=$page&limit=$limit');

    if (response.statusCode == 200) {
      if (isRefresh == true) {
        clearNewData();
      }

      for (var i = 0; i < limit!; i++) {
        _newImages!.add(ImageModel.fromJson(response.data['data'][i]));
      }

      return _newImages;
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<List<ImageModel?>?> getPopularImage(
      int? page, int? limit, bool? isRefresh, bool? isTabChanged) async {
    var response = await _dio.get(
        '${ApiConstants.imageURL}?new=false&popular=true&page=$page&limit=$limit');

    if (response.statusCode == 200) {
      if (isRefresh == true) {
        clearPopularData();
      }

      for (var i = 0; i < limit!; i++) {
        _popularImages!.add(ImageModel.fromJson(response.data['data'][i]));
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

  List<ImageModel?>? getNewImageList() {
    return _newImages!;
  }

  List<ImageModel?>? getPopularImageList() {
    return _popularImages!;
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
