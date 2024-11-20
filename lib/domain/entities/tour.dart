import 'package:booking/domain/domain.dart';

class TourEntity extends ListingEntity {
  final String duration;
  final LocationEntity location;
  final ReviewEntity review;

  TourEntity({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required this.duration,
    required this.location,
    required this.review,
  });
}
