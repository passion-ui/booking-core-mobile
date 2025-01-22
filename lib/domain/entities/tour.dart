import 'package:booking/domain/domain.dart';

class TourEntity extends ProductEntity {
  final String duration;

  TourEntity({
    required super.id,
    required super.type,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required super.location,
    required super.review,
    required super.banner,
    required super.gallery,
    required super.video,
    required super.gps,
    required this.duration,
  });
}
