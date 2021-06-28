import 'package:webant_test_app/models/user.dart';
import 'package:webant_test_app/api/user_api/user_api_provider.dart';

class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();

  Future<User?> getProfileInfo() => _apiProvider.getProfileInfo();

  Future<String?> sendDataToApi({
    String? username,
    String? birthday,
    String? email,
    String? phone,
    String? fullName,
  }) =>
      _apiProvider.sendDataToApi(
          username: username,
          phone: phone,
          email: email,
          birthday: birthday,
          fullName: fullName);

  Future<List<String?>?> getUploadImagesFromUser() =>
      _apiProvider.getUploadImagesFromUser();
}
