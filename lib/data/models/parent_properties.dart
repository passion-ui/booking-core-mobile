class ParentProperties {
  final int id;
  final String title;
  final String slug;
  final String service;
  final String? displayType;
  final String? hideInSingle;

  ParentProperties({
    required this.id,
    required this.title,
    required this.slug,
    required this.service,
    this.displayType,
    this.hideInSingle,
  });

  factory ParentProperties.fromJson(Map<String, dynamic> json) {
    return ParentProperties(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      service: json['service'],
      displayType: json['display_type'],
      hideInSingle: json['hide_in_single'],
    );
  }
}
