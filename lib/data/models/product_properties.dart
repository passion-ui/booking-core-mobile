import 'models.dart';

class ProductProperties {
  final ParentProperties parent;
  final List<ChildrenProperties> children;

  ProductProperties({
    required this.parent,
    required this.children,
  });

  factory ProductProperties.fromJson(Map<String, dynamic> json) {
    return ProductProperties(
      parent: ParentProperties.fromJson(json['parent']),
      children: (json['child'] ?? [])
          .map((childJson) => ChildrenProperties.fromJson(childJson))
          .toList(),
    );
  }
}
