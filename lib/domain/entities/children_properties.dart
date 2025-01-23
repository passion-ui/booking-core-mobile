class ChildrenPropertiesEntity {
  final int id;
  final String title;
  final String? content;
  final String? imageId;
  final String? icon;
  final int attrId;
  final String slug;

  ChildrenPropertiesEntity({
    required this.id,
    required this.title,
    this.content,
    this.imageId,
    this.icon,
    required this.attrId,
    required this.slug,
  });
}
