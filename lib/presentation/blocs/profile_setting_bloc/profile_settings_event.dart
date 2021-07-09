import 'package:webant_test_app/data/models/user.dart';

abstract class ProfileSettingsEvent {
  const ProfileSettingsEvent();
}

class SendDataToApi extends ProfileSettingsEvent {
  final String? username;
  final String? birthday;
  final String? email;
  final String? phone;
  final String? fullName;

  const SendDataToApi(
      {this.username, this.birthday, this.email, this.phone, this.fullName});
}

class SetProfileAvatar extends ProfileSettingsEvent {
  final User? user;

  SetProfileAvatar({this.user});
}
