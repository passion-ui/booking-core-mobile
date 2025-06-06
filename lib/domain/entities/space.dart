import 'package:booking/domain/domain.dart';

class SpaceEntity extends ProductEntity {
  final int guests;
  final int beds;
  final int bathrooms;
  final int squares;

  SpaceEntity({
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
    required super.bookingFees,
    required this.guests,
    required this.beds,
    required this.bathrooms,
    required this.squares,
  });
}
