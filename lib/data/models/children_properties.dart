class ChildrenProperties {
  final int id;
  final String title;
  final String? content;
  final String? imageId;
  final String? icon;
  final int attrId;
  final String slug;

  ChildrenProperties({
    required this.id,
    required this.title,
    this.content,
    this.imageId,
    this.icon,
    required this.attrId,
    required this.slug,
  });

  factory ChildrenProperties.fromJson(Map<String, dynamic> json) {
    return ChildrenProperties(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageId: json['image_id'],
      icon: json['icon'],
      attrId: json['attr_id'],
      slug: json['slug'],
    );
  }
}
