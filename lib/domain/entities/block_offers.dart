import 'package:booking/domain/domain.dart';

class BlockOffersEntity extends BlockHomeEntity {
  final List<OfferEntity> offers;

  BlockOffersEntity({
    required super.title,
    required super.description,
    required this.offers,
  });
}
