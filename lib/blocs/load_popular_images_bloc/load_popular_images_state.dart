abstract class LoadPopularImageState {
  const LoadPopularImageState();
}

class InitLoadPopularImageState extends LoadPopularImageState {}

class PopularImageLoadingState extends LoadPopularImageState {}

class LoadPopularImageSuccess extends LoadPopularImageState {
  final List<String?>? popularImageFileNameList;

  const LoadPopularImageSuccess({this.popularImageFileNameList});
}

class LoadPopularImageFailed extends LoadPopularImageState {}
