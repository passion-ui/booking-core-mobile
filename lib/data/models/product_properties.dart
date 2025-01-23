import 'package:booking/domain/domain.dart';

import 'models.dart';

class ProductProperties {
  final ParentProperties parent;
  final List<ChildrenProperties> children;

  ProductProperties({
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

  factory ProductProperties.fromJson(Map<String, dynamic> json) {
    return ProductProperties(
      parent: ParentProperties.fromJson(json['parent']),
      children: List.from(json['child'] ?? []).map((childJson) {
        return ChildrenProperties.fromJson(childJson);
      }).toList(),
    );
  }
}
