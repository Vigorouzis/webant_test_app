abstract class LoadPopularImageEvent {
  const LoadPopularImageEvent();
}

class LoadPopularImage extends LoadPopularImageEvent {
  final int? page;
  final int? limit;
  final bool? isRefresh;
  final bool? isTabChanged;

  const LoadPopularImage({
    this.page,
    this.limit,
    this.isRefresh,
    this.isTabChanged,
  });
}

class SearchInPopularImageList extends LoadPopularImageEvent {
  final String searchText;

  const SearchInPopularImageList({required this.searchText});
}

