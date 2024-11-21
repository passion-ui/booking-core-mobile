import 'package:booking/domain/domain.dart';

class SpaceEntity extends ListingEntity {
  final int guests;
  final int beds;
  final int bathrooms;
  final int squares;

  SpaceEntity({
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
    required this.beds,
    required this.bathrooms,
    required this.squares,
  });
}
