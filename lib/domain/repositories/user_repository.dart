import 'package:dio/dio.dart';
import 'package:webant_test_app/data/models/user.dart';

abstract class UserRepository {
  Future<User?> getProfileInfo();

  Future<User?> sendDataToApi({
    String? username,
    DateTime? birthday,
    String? email,
    String? phone,
    String? fullName,
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  });

  Future<List<String?>?> getUploadImagesFromUser();

  Future<Response?>? changePassword({
    String? oldPassword,
    String? newPassword,
    String? accessToken,
    String? clientId,
  });
}
