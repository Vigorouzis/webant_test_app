import 'package:webant_test_app/data/datasources/image_api_provider.dart';
import 'package:webant_test_app/data/models/image.dart';

import 'package:webant_test_app/domain/repositories/image_repository.dart';
import 'package:webant_test_app/injection.dart';

class ImageRepositoryImpl implements ImageRepository {
  ImageApiProvider _apiProvider = injection<ImageApiProvider>();

  @override
  Future<int?>? getNewCountOfPages() => _apiProvider.getNewCountOfPages();

  @override
  Future<List<ImageModel?>?> getNewImage(
          int? page, int? limit, bool? isRefresh, bool? isTabChanged) =>
      _apiProvider.getNewImage(page, limit, isRefresh, isTabChanged);

  @override
  List<ImageModel?>? getNewImageList() => _apiProvider.getNewImageList();

  @override
  List<ImageModel?>? getPopularImageList() =>
      _apiProvider.getPopularImageList();

  @override
  Future<int?>? getPopularCountOfPages() =>
      _apiProvider.getPopularCountOfPages();

  @override
  Future<List<ImageModel?>?> getPopularImage(
          int? page, int? limit, bool? isRefresh, bool? isTabChanged) =>
      _apiProvider.getPopularImage(page, limit, isRefresh, isTabChanged);
}
