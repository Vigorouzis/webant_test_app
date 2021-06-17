abstract class LoadImageState {
  const LoadImageState();
}

class InitLoadImageState extends LoadImageState {}

class ImageLoadingState extends LoadImageState {}

class LoadImageSuccess extends LoadImageState {
  final List<String?>? newImageFileNameList;

  const LoadImageSuccess({this.newImageFileNameList});
}

class LoadImageFailed extends LoadImageState {}
