import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/models/image.dart';
import 'package:webant_test_app/data/repositories/image_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/load_popular_images_bloc/load_popular_images_event.dart';
import 'package:webant_test_app/presentation/blocs/load_popular_images_bloc/load_popular_images_state.dart';
import 'package:connectivity/connectivity.dart';

class LoadPopularImageBloc
    extends Bloc<LoadPopularImageEvent, LoadPopularImageState> {
  LoadPopularImageBloc({required ImageRepositoryImpl? imageRepository})
      : _imageRepository = imageRepository,
        super(InitLoadPopularImageState());

  ImageRepositoryImpl? _imageRepository;

  @override
  Stream<LoadPopularImageState> mapEventToState(
      LoadPopularImageEvent event) async* {
    if (event is LoadPopularImage) {
      yield PopularImageLoadingState();
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        try {
          var response = await _imageRepository!.getPopularImage(
              event.page, event.limit, event.isRefresh, event.isTabChanged);
          yield LoadPopularImageSuccess(popularImageFileNameList: response);
        } catch (_) {
          yield LoadPopularImageFailed();
        }
      } else {
        yield LoadPopularImageFailed();
      }
    }
    if (event is SearchInPopularImageList) {
      List<ImageModel?> searchNewImageList = [];

      List<ImageModel?> result = [];

      result = _imageRepository!.getPopularImageList()!;

      result.forEach((element) {
        if (element!.name!.contains(event.searchText)) {
          searchNewImageList.add(element);
        }
      });
      if (searchNewImageList.isNotEmpty) {
        yield LoadPopularImageSuccess(
            popularImageFileNameList: searchNewImageList);
      } else {
        yield LoadPopularImageFailed();
      }
    }
  }
}
