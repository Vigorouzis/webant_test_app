import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/datasources/server_not_responding.dart';
import 'package:webant_test_app/data/repositories/auth_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/registration_bloc/registration_event.dart';
import 'package:webant_test_app/presentation/blocs/registration_bloc/registration_state.dart';
import 'package:webant_test_app/domain/repositories/auth_repository.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(InitRegistrationState());

  var _authRepository = AuthRepositoryImpl();

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is Registration) {
      yield RegistrationLoading();
      try {
        var response = await _authRepository.registrationNewUser(
          fullName: event.fullName,
          birthday: event.birthday,
          email: event.email,
          password: event.password,
          phone: event.phone,
          username: event.username,
        );
        if (response == 'OK') {
          var auth = await _authRepository.authorization(
              username: event.username,
              password: event.password);
          if (auth == 'OK') {
            yield RegistrationSuccess();
          } else {
            yield RegistrationError();
          }
        } else {
          yield RegistrationError();
        }
      } on ServerNorResponding catch (error) {
        yield RegistrationError(message: error.message);
      }
    }
  }
}
