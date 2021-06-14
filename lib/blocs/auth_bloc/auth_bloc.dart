import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/auth_bloc/auth_event.dart';
import 'package:webant_test_app/blocs/auth_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthorizationEvent) {
      try {
        //TODO: запрос на сервер для авторизации
        yield AuthSuccess();
      } catch (_) {
        yield AuthError();
      }
    }
  }
}
