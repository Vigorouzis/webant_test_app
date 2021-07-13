import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/repositories/auth_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:webant_test_app/presentation/blocs/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitAuthState());
  var _authRepository = AuthRepositoryImpl();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthorizationEvent) {
      yield AuthLoading();
      try {
        var response = await _authRepository.authorization(
          username: event.email,
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
