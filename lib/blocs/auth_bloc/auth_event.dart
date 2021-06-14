abstract class AuthEvent {
  const AuthEvent();
}

class AuthorizationEvent extends AuthEvent {}

class RegistrationEvent extends AuthEvent {
  final String? fullName;
  final String? birthday;
  final String? email;
  final String? password;

  RegistrationEvent({this.fullName, this.birthday, this.email, this.password});
}
