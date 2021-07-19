import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/repositories/user_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/profile_bloc/profile_event.dart';
import 'package:webant_test_app/presentation/blocs/profile_bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({UserRepositoryImpl? userRepository})
      : _userRepository = userRepository,
        super(InitProfileState());

  UserRepositoryImpl? _userRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetDataAboutProfile) {
      yield ProfileLoadingState();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        try {
          var _response = await  _userRepository?.getProfileInfo();
          var _imagesList = await _userRepository?.getUploadImagesFromUser();
          _response!.uploadImages = _imagesList;
          yield ProfileSuccess(user: _response);
        } catch (_) {
          yield ProfileFailed();
        }
      } else {
        yield ProfileFailed();
      }
    }
  }
}
