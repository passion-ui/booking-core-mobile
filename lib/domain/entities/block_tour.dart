import 'package:booking/domain/domain.dart';

class BlockTourEntity extends BlockHomeEntity {
  final List<ProductEntity> items;
  final ListingViewStyle style;

  BlockTourEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
