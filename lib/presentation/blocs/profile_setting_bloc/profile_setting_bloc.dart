import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_test_app/data/models/user.dart';
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
        if (response != null) {
          yield ProfileSettingsLoaded(user: response);
        } else {
          yield ProfileSettingsFailed();
        }
      } catch (_) {
        yield ProfileSettingsFailed();
      }
    }

    if (event is SetProfileAvatar) {
      yield ProfileSettingsLoadingState();
      _getFromGallery(event.user);
      if (event.user!.avatar != null) {
        yield InitProfileSettingsState(user: event.user);
      }
    }
  }

  void _getFromGallery(User? user) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      user!.avatar = File(pickedFile.path);
    }
  }
}
