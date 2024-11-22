import 'package:booking/domain/domain.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      image: image,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
