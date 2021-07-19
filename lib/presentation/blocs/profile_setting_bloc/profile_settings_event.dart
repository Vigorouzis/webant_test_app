import 'package:webant_test_app/data/models/user.dart';

abstract class ProfileSettingsEvent {
  const ProfileSettingsEvent();
}

class SendDataToApi extends ProfileSettingsEvent {
  final String? username;
  final DateTime? birthday;
  final String? email;
  final String? phone;
  final String? fullName;
  final String? oldPassword;
  final String? newPassword;
  final String? confirmPassword;

  const SendDataToApi({
    this.username,
    this.birthday,
    this.email,
    this.phone,
    this.fullName,
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  });
}

class SetProfileAvatar extends ProfileSettingsEvent {
  final User? user;

  SetProfileAvatar({this.user});
}
