import 'package:booking/domain/domain.dart';

class ProductPropertiesEntity {
  final ParentPropertiesEntity parent;
  final List<ChildrenPropertiesEntity> children;

  ProductPropertiesEntity({
    required this.parent,
    required this.children,
  });
}
