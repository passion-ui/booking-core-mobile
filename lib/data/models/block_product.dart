import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockProductModel extends BlockHomeModel {
  final List<String> products;
  final String image;

  BlockProductModel({
    required super.title,
    required super.description,
    required this.products,
    required this.image,
  });

  @override
  BlockHomeEntity toEntity() {
    return BlockProductEntity(
      title: title,
      description: description,
      products: products,
      image: image,
    );
  }

  factory BlockProductModel.fromJson(Map<String, dynamic> json) {
    return BlockProductModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      products: List<String>.from(json['model']['service_types']),
      image: json['model']['bg_image_url'] ?? '',
    );
  }
}
