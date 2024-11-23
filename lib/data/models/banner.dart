import 'package:booking/domain/domain.dart';

class BannerModel {
  final String title;
  final String description;
  final String action;
  final String featured;
  final String icon;
  final String image;

  BannerModel({
    required this.title,
    required this.description,
    required this.action,
    required this.featured,
    required this.icon,
    required this.image,
  });

  BannerEntity toEntity() {
    return BannerEntity(
      title: title,
      description: description,
      action: action,
      featured: featured,
      icon: icon,
      image: image,
    );
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      title: json['title'] ?? '',
      description: json['desc'] ?? json['sub_title'] ?? '',
      action: json['link_title'] ?? '',
      featured: json['featured_text'] ?? '',
      icon: json['featured_icon'] ?? '',
      image: json['background_image_url'] ?? '',
    );
  }
}
