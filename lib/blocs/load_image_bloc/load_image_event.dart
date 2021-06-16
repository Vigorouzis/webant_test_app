abstract class LoadImageEvent {
  const LoadImageEvent();
}

class LoadNewImage extends LoadImageEvent {
  final int? page;
  final int? limit;

  LoadNewImage({this.page, this.limit});
}

class LoadPopularImage extends LoadImageEvent {
  final int? page;
  final int? limit;

  LoadPopularImage({this.page, this.limit});
}
