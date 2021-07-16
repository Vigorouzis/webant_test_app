abstract class RegistrationState {
  const RegistrationState();
}

class InitRegistrationState extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final String? message;

  RegistrationError({this.message});
}
