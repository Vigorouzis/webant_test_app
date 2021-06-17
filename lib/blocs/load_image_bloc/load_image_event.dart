abstract class LoadImageEvent {
  const LoadImageEvent();
}

class LoadNewImage extends LoadImageEvent {
  final int? page;
  final int? limit;
  final bool? isRefresh;

  LoadNewImage({this.page, this.limit, this.isRefresh});
}
