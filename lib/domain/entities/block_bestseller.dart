import 'package:booking/domain/domain.dart';

enum ListingViewStyle {
  normal,
  grid,
  list,
}

class BlockBestSellerEntity extends BlockHomeEntity {
  final List<ListingEntity> items;
  final ListingViewStyle style;

  BlockBestSellerEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
