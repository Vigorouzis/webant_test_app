import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_event.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_state.dart';
import 'package:webant_test_app/api/image_api/image_repository.dart';
import 'package:connectivity/connectivity.dart';

class LoadImageBloc extends Bloc<LoadImageEvent, LoadImageState> {
  LoadImageBloc({required ImageRepository imageRepository})
      : _imageRepository = imageRepository,
        super(InitLoadImageState());

  ImageRepository _imageRepository;

  @override
  Stream<LoadImageState> mapEventToState(LoadImageEvent event) async* {
    if (event is LoadNewImage) {
      yield ImageLoadingState();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        try {
          var response = await _imageRepository.getNewImage(
              event.page, event.limit, event.isRefresh, event.isTabChanged);
          yield LoadImageSuccess(newImageList: response);
        } catch (_) {
          yield LoadImageFailed();
        }
      } else {
        yield LoadImageFailed();
      }
    }
    if(event is GetData){
      var response = _imageRepository.getNewImageList();
       yield LoadImageSuccess(newImageList: response);
    }
  }
}
