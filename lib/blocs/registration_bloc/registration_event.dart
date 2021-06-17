abstract class RegistrationEvent {
  const RegistrationEvent();
}

class Registration extends RegistrationEvent {
  final String? fullName;
  final String? birthday;
  final String? email;
  final String? password;
  final String? username;
  final String? phone;

  Registration({
    this.fullName,
    this.birthday,
    this.email,
    this.password,
    this.username,
    this.phone,
  });
}
