class NewsEvent {}

class OnLoadNews extends NewsEvent {
  final bool isLoadMore;
  final String? keyword;

  OnLoadNews({
    this.isLoadMore = false,
    this.keyword,
  });
}
