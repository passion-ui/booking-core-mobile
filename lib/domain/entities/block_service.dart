import 'package:booking/domain/domain.dart';

class BlockServiceEntity extends BlockHomeEntity {
  final List<String> services;
  final String image;

  BlockServiceEntity({
    required super.title,
    required super.description,
    required this.services,
    required this.image,
  });
}
