import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/models/image.dart';
import 'package:webant_test_app/data/repositories/Connectivity.dart';
import 'package:webant_test_app/data/repositories/image_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/load_image_bloc/load_image_event.dart';
import 'package:webant_test_app/presentation/blocs/load_image_bloc/load_image_state.dart';

class LoadImageBloc extends Bloc<LoadImageEvent, LoadImageState> {
  LoadImageBloc({required ImageRepositoryImpl? imageRepository})
      : _imageRepository = imageRepository,
        super(InitLoadImageState());

  ImageRepositoryImpl? _imageRepository;

  @override
  Stream<LoadImageState> mapEventToState(LoadImageEvent event) async* {
    if (event is LoadNewImage) {
      yield ImageLoadingState();
      if (await ConnectivityClass().checkConnectivity()) {
        try {
          var response = await _imageRepository!.getNewImage(
              event.page, event.limit, event.isRefresh, event.isTabChanged);
          yield LoadImageSuccess(newImageList: response);
        } catch (_) {
          yield LoadImageFailed();
        }
      } else {
        yield LoadImageFailed();
      }
    }
    if (event is SearchInNewImageList) {
      List<ImageModel?> searchNewImageList = [];

      List<ImageModel?> result = [];
      try {
        result = _imageRepository!.getNewImageList()!;
      } catch (_) {
        throw Exception('failed');
      }
      result.forEach((element) {
        if (element!.name!.contains(event.searchText)) {
          searchNewImageList.add(element);
        }
      });
      if (searchNewImageList.isNotEmpty) {
        yield LoadImageSuccess(newImageList: searchNewImageList);
      } else {
        yield LoadImageFailed();
      }
    }
  }
}
