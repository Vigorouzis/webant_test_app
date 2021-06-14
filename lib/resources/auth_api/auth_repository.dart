import 'package:webant_test_app/resources/auth_api/auth_api_provider.dart';

class AuthRepository {
  var _authApiProvider = AuthApiProvider();

  Future<void> registrationNewUser({
    String? fullName,
    String? birthday,
    String? email,
    String? password,
  }) =>
      _authApiProvider.registrationNewUser(
        fullName: fullName,
        birthday: birthday,
        email: email,
        password: password,
      );
}
