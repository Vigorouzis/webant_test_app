abstract class ProfileSettingsState {
  const ProfileSettingsState();
}

class InitProfileSettingsState extends ProfileSettingsState {}

class ProfileSettingsLoadingState extends ProfileSettingsState {}

class ProfileSettingsLoaded extends ProfileSettingsState {
  const ProfileSettingsLoaded();
}

class ProfileSettingsFailed extends ProfileSettingsState {}
