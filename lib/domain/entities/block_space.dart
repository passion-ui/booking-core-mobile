import 'package:booking/domain/domain.dart';

class BlockSpaceEntity extends BlockHomeEntity {
  final List<ProductEntity> items;
  final ListingViewStyle style;

  BlockSpaceEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
