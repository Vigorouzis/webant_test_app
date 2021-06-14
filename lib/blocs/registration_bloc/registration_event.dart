abstract class RegistrationEvent {
  const RegistrationEvent();
}

class Registration extends RegistrationEvent {
  final String? fullName;
  final String? birthday;
  final String? email;
  final String? password;

  Registration({this.fullName, this.birthday, this.email, this.password});
}
