import 'package:webant_test_app/data/datasources/user_api_provider.dart';
import 'package:webant_test_app/data/models/user.dart';
import 'package:webant_test_app/domain/repositories/user_repository.dart';
import 'package:webant_test_app/injection.dart';

class UserRepositoryImpl implements UserRepository {
  UserApiProvider _apiProvider = injection<UserApiProvider>();

  @override
  Future<User?> getProfileInfo() => _apiProvider.getProfileInfo();

  @override
  Future<User?> sendDataToApi({
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

  @override
  Future<List<String?>?> getUploadImagesFromUser() =>
      _apiProvider.getUploadImagesFromUser();
}
