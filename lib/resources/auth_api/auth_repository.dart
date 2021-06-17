import 'package:webant_test_app/resources/auth_api/auth_api_provider.dart';

class AuthRepository {
  var _authApiProvider = AuthApiProvider();

  Future<String> registrationNewUser({
    String? fullName,
    String? birthday,
    String? email,
    String? password,
    String? username,
    String? phone,
  }) =>
      _authApiProvider.registrationNewUser(
        fullName: fullName,
        birthday: birthday,
        email: email,
        password: password,
        username: username,
        phone: phone,
      );

  Future<String?> authorization({
    String? email,
    String? password,
  }) =>
      _authApiProvider.authorization(
        username: email,
        password: password,
      );
}
