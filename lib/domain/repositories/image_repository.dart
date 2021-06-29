import 'package:webant_test_app/data/models/image.dart';

abstract class ImageRepository {
  Future<List<ImageModel?>?> getNewImage(
      int? page, int? limit, bool? isRefresh, bool? isTabChanged);

  Future<List<ImageModel?>?> getPopularImage(
      int? page, int? limit, bool? isRefresh, bool? isTabChanged);

  Future<int?>? getNewCountOfPages();

  Future<int?>? getPopularCountOfPages();

  List<ImageModel?>? getPopularImageList();

  List<ImageModel?>? getNewImageList();
}
