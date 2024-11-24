class ListingEntity<T> {
  final List<T> items;
  final int total;
  final int totalPages;

  ListingEntity({
    required this.items,
    required this.total,
    required this.totalPages,
  });

  bool get allowMore => items.length < total;
}
