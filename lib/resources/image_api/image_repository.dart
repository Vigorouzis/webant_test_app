import 'package:webant_test_app/resources/image_api/image_api_provider.dart';

class ImageRepository {
  ImageApiProvider _apiProvider = ImageApiProvider();

  Future<List<String?>?> geNewImage(int? page, int? limit) =>
      _apiProvider.getNewImage(page, limit);
}
