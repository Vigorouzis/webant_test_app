abstract class LoadImageState {
  const LoadImageState();
}

class InitLoadImageState extends LoadImageState {}

class ImageLoadingState extends LoadImageState {}

class LoadImageSuccess extends LoadImageState {
  final List<String?>? imageFileNameList;

  LoadImageSuccess({this.imageFileNameList});
}

class LoadImageFailed extends LoadImageState {}
