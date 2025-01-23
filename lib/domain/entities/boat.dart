import 'package:booking/domain/domain.dart';

class BoatEntity extends ProductEntity {
  final int guests;
  final int cabins;
  final String length;
  final String speed;

  BoatEntity({
    required super.id,
    required super.type,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required super.address,
    required super.location,
    required super.review,
    required super.banner,
    required super.gallery,
    required super.video,
    required super.gps,
    required super.properties,
    required this.guests,
    required this.cabins,
    required this.length,
    required this.speed,
  });
}
