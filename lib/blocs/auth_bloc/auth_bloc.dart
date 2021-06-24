import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/auth_bloc/auth_event.dart';
import 'package:webant_test_app/blocs/auth_bloc/auth_state.dart';
import 'package:webant_test_app/api/auth_api/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitAuthState());
  var _authRepository = AuthRepository();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthorizationEvent) {
      yield AuthLoading();
      try {
        var response = await _authRepository.authorization(
          email: event.email,
          password: event.password,
        );
        if (response == 'OK') {
          yield AuthSuccess();
        } else {
          yield AuthError();
        }
      } catch (_) {
        yield AuthError();
      }
    }
  }
}
