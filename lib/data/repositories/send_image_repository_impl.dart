import 'dart:io';

import 'package:webant_test_app/data/datasources/send_image_api.dart';
import 'package:webant_test_app/domain/repositories/send_image_repository.dart';
import 'package:webant_test_app/injection.dart';

class SendImageRepositoryImpl implements SendImageRepository {
  SendImageApiProvider _imageApi = injection<SendImageApiProvider>();

  @override
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
