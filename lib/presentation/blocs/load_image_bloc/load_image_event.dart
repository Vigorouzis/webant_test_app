abstract class LoadImageEvent {
  const LoadImageEvent();
}

class LoadNewImage extends LoadImageEvent {
  final int? page;
  final int? limit;
  final bool? isRefresh;
  final bool? isTabChanged;
  final bool? isFirstInit;

  const LoadNewImage({
    this.page,
    this.limit,
    this.isRefresh,
    this.isTabChanged,
    this.isFirstInit,
  });
}

class SearchInNewImageList extends LoadImageEvent {
  final String searchText;

  const SearchInNewImageList({required this.searchText});
}
