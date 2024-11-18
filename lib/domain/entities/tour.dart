import 'package:booking/domain/domain.dart';

class TourEntity extends ListingEntity {
  final num price;
  final num salePrice;
  final String saleOff;
  final String duration;
  final LocationEntity location;
  final ReviewEntity review;

  TourEntity({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required this.price,
    required this.salePrice,
    required this.saleOff,
    required this.duration,
    required this.location,
    required this.review,
  });
}
