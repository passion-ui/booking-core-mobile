import 'package:booking/domain/domain.dart';

class BoatEntity extends ListingEntity {
  final int guests;
  final int cabins;
  final String length;
  final String speed;

  BoatEntity({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required super.location,
    required super.review,
    required this.guests,
    required this.cabins,
    required this.length,
    required this.speed,
  });
}
