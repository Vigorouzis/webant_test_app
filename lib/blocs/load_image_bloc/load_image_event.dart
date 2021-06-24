abstract class LoadImageEvent {
  const LoadImageEvent();
}

class LoadNewImage extends LoadImageEvent {
  final int? page;
  final int? limit;
  final bool? isRefresh;
  final bool? isTabChanged;

  const LoadNewImage(
      {this.page, this.limit, this.isRefresh, this.isTabChanged});
}

class GetData extends LoadImageEvent {
  const GetData();
}
