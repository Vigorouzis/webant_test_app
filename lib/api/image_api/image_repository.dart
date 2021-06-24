import 'package:webant_test_app/models/image.dart';
import 'package:webant_test_app/api/image_api/image_api_provider.dart';

class ImageRepository {
  ImageApiProvider _apiProvider = ImageApiProvider();

  Future<List<ImageModel?>?> getNewImage(int? page, int? limit, bool? isRefresh, bool? isTabChanged) =>
      _apiProvider.getNewImage(page, limit, isRefresh, isTabChanged);

  Future<List<ImageModel?>?> getPopularImage(
          int? page, int? limit, bool? isRefresh, bool? isTabChanged) =>
      _apiProvider.getPopularImage(page, limit, isRefresh, isTabChanged);

  Future<int?>? getNewCountOfPages() => _apiProvider.getNewCountOfPages();

  Future<int?>? getPopularCountOfPages() =>
      _apiProvider.getPopularCountOfPages();

  List<ImageModel?>? getNewImageList() =>  _apiProvider.getNewImageList();
}
