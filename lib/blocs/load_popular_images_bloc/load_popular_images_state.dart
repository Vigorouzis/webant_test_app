import 'package:webant_test_app/models/image.dart';

abstract class LoadPopularImageState {
  const LoadPopularImageState();
}

class InitLoadPopularImageState extends LoadPopularImageState {}

class PopularImageLoadingState extends LoadPopularImageState {}

class LoadPopularImageSuccess extends LoadPopularImageState {
  final List<ImageModel?>? popularImageFileNameList;

  const LoadPopularImageSuccess({this.popularImageFileNameList});
}

class LoadPopularImageFailed extends LoadPopularImageState {}
