import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_test_app/data/repositories/send_image_repository_impl.dart';
import 'package:webant_test_app/presentation/blocs/send_image_bloc/send_image_event.dart';
import 'package:webant_test_app/presentation/blocs/send_image_bloc/send_image_state.dart';

class SendImageBloc extends Bloc<SendImageEvent, SendImageState> {
  SendImageBloc({SendImageRepositoryImpl? repository})
      : _repository = repository,
        super(InitSendImageState());

  SendImageRepositoryImpl? _repository;

  @override
  Stream<SendImageState> mapEventToState(SendImageEvent event) async* {
    if (event is SendImage) {
      yield SendImageLoading();
      try {
        var response = await _repository!.sendImageToApi(
            name: event.name,
            description: event.description,
            newImage: event.newImage,
            popularImage: event.popularImage,
            file: event.file);
        if (response == 'OK') {
          yield SendImageSuccess();
        } else {
          yield SendImageError();
        }
      } catch (_) {
        yield SendImageError();
      }
    }
  }
}
