import 'package:webant_test_app/data/models/user.dart';

abstract class UserRepository {
  Future<User?> getProfileInfo();

  Future<User?> sendDataToApi({
    String? username,
    DateTime? birthday,
    String? email,
    String? phone,
    String? fullName,
  });

  Future<List<String?>?> getUploadImagesFromUser();
}
