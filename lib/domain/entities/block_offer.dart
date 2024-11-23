import 'package:booking/domain/domain.dart';

class BlockOfferEntity extends BlockHomeEntity {
  final List<BannerEntity> items;

  BlockOfferEntity({
    required super.title,
    required super.description,
    required this.items,
  });
}
