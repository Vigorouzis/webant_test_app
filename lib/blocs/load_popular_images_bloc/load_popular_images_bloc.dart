import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_event.dart';
import 'package:webant_test_app/blocs/load_popular_images_bloc/load_popular_images_state.dart';
import 'package:webant_test_app/api/image_api/image_repository.dart';
import 'package:connectivity/connectivity.dart';

class LoadPopularImageBloc
    extends Bloc<LoadPopularImageEvent, LoadPopularImageState> {
  LoadPopularImageBloc({required ImageRepository imageRepository})
      : _imageRepository = imageRepository,
        super(InitLoadPopularImageState());

  ImageRepository _imageRepository;

  @override
  Stream<LoadPopularImageState> mapEventToState(
      LoadPopularImageEvent event) async* {
    if (event is LoadPopularImage) {
      yield PopularImageLoadingState();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        try {
          var response = await _imageRepository.getPopularImage(
              event.page, event.limit, event.isRefresh, event.isTabChanged);
          yield LoadPopularImageSuccess(popularImageFileNameList: response);
        } catch (_) {
          yield LoadPopularImageFailed();
        }
      } else {
        yield LoadPopularImageFailed();
      }
    }
    if (event is GetPopularData) {
      var response = _imageRepository.getNewImageList();
      yield LoadPopularImageSuccess(popularImageFileNameList: response);
    }
  }
}
