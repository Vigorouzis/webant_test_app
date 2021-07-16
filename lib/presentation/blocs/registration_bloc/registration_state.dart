import 'package:webant_test_app/data/models/enums/field_error.dart';

class RegistrationState {
  final FieldError? nameError;
  final FieldError? usernameError;
  final FieldError? phoneError;
  final FieldError? birthdayError;
  final FieldError? emailError;
  final FieldError? passwordError;
  final FieldError? confirmPasswordError;

  RegistrationState({
    this.nameError,
    this.usernameError,
    this.phoneError,
    this.birthdayError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });
}

class InitRegistrationState extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final String? message;

  RegistrationError({this.message});

}

