import 'package:webant_test_app/models/image.dart';
import 'package:webant_test_app/resources/image_api/image_api_provider.dart';

class ImageRepository {
  ImageApiProvider _apiProvider = ImageApiProvider();

  Future<List<ImageModel?>?> getNewImage(int? page, int? limit, bool? isRefresh) =>
      _apiProvider.getNewImage(page, limit, isRefresh);

  Future<List<ImageModel?>?> getPopularImage(
          int? page, int? limit, bool? isRefresh) =>
      _apiProvider.getPopularImage(page, limit, isRefresh);

  Future<int?>? getNewCountOfPages() => _apiProvider.getNewCountOfPages();

  Future<int?>? getPopularCountOfPages() =>
      _apiProvider.getPopularCountOfPages();
}
