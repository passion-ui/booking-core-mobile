import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockServicesModel extends BlockHomeModel {
  final List<String> services;
  final String image;

  BlockServicesModel({
    required super.title,
    required super.description,
    required this.services,
    required this.image,
  });

  @override
  BlockHomeEntity toEntity() {
    return BlockServicesEntity(
      title: title,
      description: description,
      services: services,
      image: image,
    );
  }

  factory BlockServicesModel.fromJson(Map<String, dynamic> json) {
    return BlockServicesModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      services: List<String>.from(json['model']['service_types']),
      image: json['model']['bg_image_url'] ?? '',
    );
  }
}
