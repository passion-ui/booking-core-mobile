import 'package:booking/domain/domain.dart';

class BlockLocationEntity extends BlockHomeEntity {
  final List<CategoryEntity> items;

  BlockLocationEntity({
    required super.title,
    required super.description,
    required this.items,
  });
}
