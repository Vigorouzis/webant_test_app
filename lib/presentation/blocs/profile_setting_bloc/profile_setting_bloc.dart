import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/repositories/user_repository_impl.dart';
import 'package:webant_test_app/domain/repositories/user_repository.dart';
import 'package:webant_test_app/presentation/blocs/profile_setting_bloc/profile_settings_event.dart';
import 'package:webant_test_app/presentation/blocs/profile_setting_bloc/profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc({UserRepositoryImpl? repository})
      : _userRepository = repository,
        super(InitProfileSettingsState());

  UserRepositoryImpl? _userRepository;

  @override
  Stream<ProfileSettingsState> mapEventToState(
      ProfileSettingsEvent event) async* {
    if (event is SendDataToApi) {
      yield ProfileSettingsLoadingState();
      try {
        var response = await _userRepository!.sendDataToApi(
          fullName: event.fullName,
          birthday: event.birthday,
          email: event.email,
          phone: event.phone,
          username: event.username,
        );
        if (response == 'OK') {
          yield ProfileSettingsLoaded();
        } else {
          yield ProfileSettingsFailed();
        }
      } catch (_) {
        yield ProfileSettingsFailed();
      }
    }
  }
}
