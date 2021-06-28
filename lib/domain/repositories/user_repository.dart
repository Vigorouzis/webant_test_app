import 'package:webant_test_app/data/models/user.dart';

abstract class UserRepository {
  Future<User?> getProfileInfo();

  Future<String?> sendDataToApi({
    String? username,
    String? birthday,
    String? email,
    String? phone,
    String? fullName,
  });

  Future<List<String?>?> getUploadImagesFromUser();
}
