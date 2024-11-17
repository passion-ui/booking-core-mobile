import 'package:booking/domain/domain.dart';

class ListingEntity {
  final int id;
  final String title;
  final String price;
  final String image;
  final String content;
  final LocationEntity location;
  final ReviewEntity review;

  ListingEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.content,
    required this.location,
    required this.review,
  });
}
