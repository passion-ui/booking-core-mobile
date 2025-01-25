import 'package:booking/domain/domain.dart';

class HotelEntity extends ProductEntity {
  final double? point;
  final List<FAQEntity>? policies;
  final String? checkInTime;
  final String? checkOutTime;

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
    this.point,
    this.policies,
    this.checkInTime,
    this.checkOutTime,
  });
}
