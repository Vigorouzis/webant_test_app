import 'package:webant_test_app/data/models/image.dart';

abstract class LoadImageState {
  const LoadImageState();
}

class InitLoadImageState extends LoadImageState {}

class ImageLoadingState extends LoadImageState {}

class LoadImageSuccess extends LoadImageState {
  final List<ImageModel?>? newImageList;

  const LoadImageSuccess({this.newImageList});
}

class LoadImageFailed extends LoadImageState {}
