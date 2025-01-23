class ParentPropertiesEntity {
  final int id;
  final String title;
  final String slug;
  final String service;
  final String? displayType;
  final String? hideInSingle;

  ParentPropertiesEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.service,
    this.displayType,
    this.hideInSingle,
  });
}
