import 'package:booking/domain/domain.dart';

class BlockProductEntity extends BlockHomeEntity {
  final List<String> products;
  final String image;

  BlockProductEntity({
    required super.title,
    required super.description,
    required this.products,
    required this.image,
  });
}
