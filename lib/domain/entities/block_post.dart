import 'package:booking/domain/domain.dart';

class BlockPostEntity extends BlockHomeEntity {
  final List<PostEntity> items;
  final ListingViewStyle style;

  BlockPostEntity({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });
}
