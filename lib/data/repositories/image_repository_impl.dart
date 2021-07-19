import 'package:dio/dio.dart';
import 'package:webant_test_app/domain/repositories/image_repository.dart';
import 'package:webant_test_app/injection.dart';
import 'package:webant_test_app/data/models/image.dart';
import 'package:webant_test_app/utils/api_constants.dart';

class ImageRepositoryImpl implements ImageRepository {
  var _dio = injection.get<Dio>();
  List<ImageModel?>? _newImages = [];
  List<ImageModel?>? _popularImages = [];

  @override
  Future<List<ImageModel?>?> getNewImage(
      int? page, int? limit, bool? isRefresh, bool? isTabChanged) async {
    var response = await _dio.get(
        '${ApiConstants.imageURL}?new=true&popular=false&page=$page&limit=$limit');

    if (response.statusCode == 200) {
      if (isRefresh == true) {
        clearNewData();
      }

      List<dynamic> getImagesList = response.data['data'];
      getImagesList.forEach((element) {
        _newImages!.add(ImageModel.fromJson(element));
      });

      return _newImages;
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Future<List<ImageModel?>?> getPopularImage(
      int? page, int? limit, bool? isRefresh, bool? isTabChanged) async {
    var response = await _dio.get(
        '${ApiConstants.imageURL}?new=false&popular=true&page=$page&limit=$limit');

    if (response.statusCode == 200) {
      if (isRefresh == true) {
        clearPopularData();
      }

      List<dynamic> getImagesList = response.data['data'];
      getImagesList.forEach((element) {
        _popularImages!.add(ImageModel.fromJson(element));
      });
      return _popularImages;
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  void clearNewData() {
    _newImages?.clear();
  }

  @override
  void clearPopularData() {
    _popularImages?.clear();
  }

  @override
  List<ImageModel?>? getNewImageList() {
    return _newImages!;
  }

  @override
  List<ImageModel?>? getPopularImageList() {
    return _popularImages!;
  }

  @override
  Future<int?>? getNewCountOfPages() async {
    var response = await _dio
        .get('${ApiConstants.imageURL}?new=true&popular=false&&limit=10');
    return response.data['countOfPages'];
  }

  @override
  Future<int?>? getPopularCountOfPages() async {
    var response = await _dio
        .get('${ApiConstants.imageURL}?new=false&popular=true&&limit=10');
    return response.data['countOfPages'];
  }
}
