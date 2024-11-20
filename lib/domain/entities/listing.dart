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
  final bool isFeatured;
  final num price;
  final num salePrice;
  final String saleOff;

  ListingEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.isFeatured,
    required this.price,
    required this.salePrice,
    required this.saleOff,
  });
}
