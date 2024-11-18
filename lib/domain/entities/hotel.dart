import 'package:booking/domain/domain.dart';

class HotelEntity extends ListingEntity {
  final num price;
  final LocationEntity location;
  final ReviewEntity review;

  HotelEntity({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required this.price,
    required this.location,
    required this.review,
  });
}
