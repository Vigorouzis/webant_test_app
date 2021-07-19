import 'package:webant_test_app/data/models/user.dart';

abstract class ProfileSettingsState {
  const ProfileSettingsState();
}

class InitProfileSettingsState extends ProfileSettingsState {
  final User? user;

  const InitProfileSettingsState({this.user});
}

class ProfileSettingsLoadingState extends ProfileSettingsState {}

class ProfileSettingsLoaded extends ProfileSettingsState {
  final User? user;

  const ProfileSettingsLoaded({this.user});
}

class ProfileSettingsFailed extends ProfileSettingsState {}
