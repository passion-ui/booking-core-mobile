import 'package:booking/domain/domain.dart';

class CarEntity extends ProductEntity {
  final int passenger;
  final String gear;
  final int baggage;
  final int door;

  CarEntity({
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
    required this.passenger,
    required this.gear,
    required this.baggage,
    required this.door,
  });
}
