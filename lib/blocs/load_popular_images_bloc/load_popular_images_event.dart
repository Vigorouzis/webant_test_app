abstract class LoadPopularImageEvent {
  const LoadPopularImageEvent();
}

class LoadPopularImage extends LoadPopularImageEvent {
  final int? page;
  final int? limit;
  final bool? isRefresh;

  LoadPopularImage({this.page, this.limit, this.isRefresh});
}