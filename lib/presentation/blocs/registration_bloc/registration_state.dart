import 'package:webant_test_app/data/models/enums/field_error.dart';

class RegistrationState {
  final bool? isBusy;
  final FieldError? nameError;
  final FieldError? usernameError;
  final FieldError? phoneError;
  final FieldError? birthdayError;
  final FieldError? emailError;
  final FieldError? passwordError;
  final FieldError? confirmPasswordError;
  final bool? isSumbmit;

  RegistrationState({
    this.isBusy,
    this.nameError,
    this.usernameError,
    this.phoneError,
    this.birthdayError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.isSumbmit = false,
  });
}

class InitRegistrationState extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final FieldError? nameError;
  final FieldError? usernameError;
  final FieldError? phoneError;
  final FieldError? birthdayError;
  final FieldError? emailError;
  final FieldError? passwordError;
  final FieldError? confirmPasswordError;

  RegistrationError(
      {this.nameError,
      this.usernameError,
      this.phoneError,
      this.birthdayError,
      this.emailError,
      this.passwordError,
      this.confirmPasswordError});
}
