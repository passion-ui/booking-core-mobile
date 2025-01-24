import 'package:booking/domain/domain.dart';

import 'models.dart';

class ProductPropertiesModel {
  final ParentProperties parent;
  final List<ChildrenProperties> children;

  ProductPropertiesModel({
    required this.parent,
    required this.children,
  });

  ProductPropertiesEntity toEntity() {
    return ProductPropertiesEntity(
      parent: parent.toEntity(),
      children: children.map((child) {
        return child.toEntity();
      }).toList(),
    );
  }

  factory ProductPropertiesModel.fromJson(Map<String, dynamic> json) {
    return ProductPropertiesModel(
      parent: ParentProperties.fromJson(json['parent']),
      children: List.from(json['child'] ?? []).map((childJson) {
        return ChildrenProperties.fromJson(childJson);
      }).toList(),
    );
  }
}
