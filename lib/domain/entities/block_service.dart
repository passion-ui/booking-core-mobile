import 'package:booking/domain/domain.dart';

class BlockServiceEntity extends BlockHomeEntity {
  final List<String> products;
  final String image;

  BlockServiceEntity({
    required super.title,
    required super.description,
    required this.products,
    required this.image,
  });
}
