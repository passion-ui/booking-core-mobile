import 'package:booking/domain/domain.dart';

class HotelEntity extends ProductEntity {
  HotelEntity({
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
    required super.video,
    required super.gps,
  });
}
