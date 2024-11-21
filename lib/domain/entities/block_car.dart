import 'package:booking/domain/domain.dart';

class BlockCarEntity extends BlockHomeEntity {
  final List<ListingEntity> items;
  final ListingViewStyle style;

  BlockCarEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
