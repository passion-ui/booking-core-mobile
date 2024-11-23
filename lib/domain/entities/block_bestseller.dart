import 'package:booking/domain/domain.dart';

class BlockBestSellerEntity extends BlockHomeEntity {
  final List<ProductEntity> items;
  final ListingViewStyle style;

  BlockBestSellerEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
