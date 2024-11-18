import 'package:booking/domain/domain.dart';

class BlockOfferEntity extends BlockHomeEntity {
  final List<OfferEntity> offers;

  BlockOfferEntity({
    required super.title,
    required super.description,
    required this.offers,
  });
}
