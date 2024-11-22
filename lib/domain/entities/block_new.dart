import 'package:booking/domain/domain.dart';

class BlockNewEntity extends BlockHomeEntity {
  final List<PostEntity> items;
  final ListingViewStyle style;

  BlockNewEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
