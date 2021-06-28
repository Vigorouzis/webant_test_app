import 'dart:io';

abstract class SendImageRepository {
  Future<String?> sendImageToApi(
      {File? file,
      String? name,
      String? description,
      bool? newImage,
      bool? popularImage});
}
