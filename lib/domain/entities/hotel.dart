import 'package:booking/domain/domain.dart';

class HotelEntity extends ListingEntity {
  final LocationEntity location;
  final ReviewEntity review;

  HotelEntity({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required this.location,
    required this.review,
  });
}
