import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_event.dart';
import 'package:webant_test_app/blocs/load_image_bloc/load_image_state.dart';
import 'package:webant_test_app/resources/image_api/image_repository.dart';

class LoadImageBloc extends Bloc<LoadImageEvent, LoadImageState> {
  LoadImageBloc() : super(InitLoadImageState());

  ImageRepository _imageRepository = ImageRepository();

  @override
  Stream<LoadImageState> mapEventToState(LoadImageEvent event) async* {
    if (event is LoadNewImage) {
      yield ImageLoadingState();
      var response = await _imageRepository.geNewImage(event.page, event.limit);
      yield LoadImageSuccess(imageFileNameList: response);
    }
  }
}
