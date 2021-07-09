import 'package:webant_test_app/data/datasources/auth_api_provider.dart';
import 'package:webant_test_app/domain/repositories/auth_repository.dart';
import 'package:webant_test_app/injection.dart';

class AuthRepositoryImpl implements AuthRepository {
  var _authApiProvider = injection<AuthApiProvider>();

  @override
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

  @override
  Future<String?> authorization({
    String? email,
    String? password,
  }) =>
      _authApiProvider.authorization(
        username: email,
        password: password,
      );
}
