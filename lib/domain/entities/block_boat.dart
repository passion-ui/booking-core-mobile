import 'package:booking/domain/domain.dart';

class BlockBoatEntity extends BlockHomeEntity {
  final List<ListingEntity> items;
  final ListingViewStyle style;

  BlockBoatEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
