import 'package:booking/domain/domain.dart';

class BlockBannerEntity extends BlockHomeEntity {
  final BannerEntity item;

  BlockBannerEntity({
    required super.title,
    required super.description,
    required this.item,
  });
}
