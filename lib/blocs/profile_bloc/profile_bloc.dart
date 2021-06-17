import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_event.dart';
import 'package:webant_test_app/blocs/profile_bloc/profile_state.dart';
import 'package:webant_test_app/resources/user_api/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({UserRepository? userRepository})
      : _userRepository = userRepository,
        super(InitProfileState());

  UserRepository? _userRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetDataAboutProfile) {
      yield ProfileLoadingState();
      var _response = await _userRepository?.getProfileInfo();
      var _imagesList = await _userRepository?.getUploadImagesFromUser();
      _response!.uploadImages = _imagesList;
      yield ProfileSuccess(user: _response);
    } else {
      yield ProfileFailed();
    }
  }
}
