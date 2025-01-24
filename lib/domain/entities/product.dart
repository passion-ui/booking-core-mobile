import 'package:booking/domain/domain.dart';

enum ListingViewStyle {
  card,
  grid,
  list,
}

class ProductEntity {
  final int id;
  final String title;
  final String type;
  final String image;
  final String content;
  final bool isFeatured;
  final num price;
  final num salePrice;
  final String saleOff;
  final String address;
  final CategoryEntity location;
  final ReviewEntity review;
  final String? banner;
  final List<String> gallery;
  final String? video;
  final GPSEntity? gps;
  final List<ProductPropertiesEntity>? properties;
  final List<FeedbackEntity>? feedbacks;

  ProductEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.image,
    required this.content,
    required this.isFeatured,
    required this.price,
    required this.salePrice,
    required this.saleOff,
    required this.address,
    required this.location,
    required this.review,
    required this.banner,
    required this.gallery,
    required this.video,
    required this.gps,
    required this.properties,
    required this.feedbacks,
  });
}
