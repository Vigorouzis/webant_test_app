import 'dart:io';

import 'package:webant_test_app/api/send_image_api/send_image_api.dart';

class SendImageRepository {
  SendImageApi _imageApi = SendImageApi();

  Future<String?> sendImageToApi(
          {File? file,
          String? name,
          String? description,
          bool? newImage,
          bool? popularImage}) =>
      _imageApi.sendImageToApi(
          file: file,
          popularImage: popularImage,
          newImage: newImage,
          description: description,
          name: name);
}
