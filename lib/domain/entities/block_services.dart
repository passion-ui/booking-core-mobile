import 'package:booking/domain/domain.dart';

class BlockServicesEntity extends BlockHomeEntity {
  final List<String> services;
  final String image;

  BlockServicesEntity({
    required super.title,
    required super.description,
    required this.services,
    required this.image,
  });
}
