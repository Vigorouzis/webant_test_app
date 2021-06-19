import 'package:webant_test_app/models/user.dart';
import 'package:webant_test_app/api/user_api/user_api_provider.dart';

class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();

  Future<User?> getProfileInfo() => _apiProvider.getProfileInfo();

  Future<List<String?>?> getUploadImagesFromUser() =>
      _apiProvider.getUploadImagesFromUser();
}
