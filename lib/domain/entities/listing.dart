enum ListingViewStyle {
  normal,
  grid,
  list,
}

class ListingEntity {
  final int id;
  final String title;
  final String image;
  final String content;

  ListingEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
  });
}
