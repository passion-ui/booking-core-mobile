import 'package:booking/domain/domain.dart';

class CarEntity extends ProductEntity {
  final int passenger;
  final String gear;
  final int baggage;
  final int door;

  CarEntity({
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
    required super.feedbacks,
    required super.faqs,
    required super.related,
    required super.enableExtraPrice,
    required super.extraServices,
    required this.passenger,
    required this.gear,
    required this.baggage,
    required this.door,
  });
}
