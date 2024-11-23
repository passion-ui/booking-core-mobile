import 'package:booking/domain/domain.dart';

enum ListingViewStyle {
  normal,
  grid,
  list,
}

class ProductEntity {
  final int id;
  final String title;
  final String image;
  final String content;
  final bool isFeatured;
  final num price;
  final num salePrice;
  final String saleOff;
  final CategoryEntity location;
  final ReviewEntity review;

  ProductEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.isFeatured,
    required this.price,
    required this.salePrice,
    required this.saleOff,
    required this.location,
    required this.review,
  });
}
