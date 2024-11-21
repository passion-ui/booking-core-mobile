import 'package:booking/domain/domain.dart';

class BlockEventEntity extends BlockHomeEntity {
  final List<ListingEntity> items;
  final ListingViewStyle style;

  BlockEventEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
