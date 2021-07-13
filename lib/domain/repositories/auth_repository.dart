abstract class AuthRepository {
  Future<String> registrationNewUser(
      {String? fullName,
      String? birthday,
      String? email,
      String? password,
      String? username,
      String? phone});

  Future<String?> authorization({String? username, String? password});
}
