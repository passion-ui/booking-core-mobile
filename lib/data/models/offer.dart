import 'package:booking/domain/domain.dart';

class OfferModel {
  final String title;
  final String description;
  final String action;
  final String featured;
  final String icon;
  final String image;

  OfferModel({
    required this.title,
    required this.description,
    required this.action,
    required this.featured,
    required this.icon,
    required this.image,
  });

  OfferEntity toEntity() {
    return OfferEntity(
      title: title,
      description: description,
      action: action,
      featured: featured,
      icon: icon,
      image: image,
    );
  }

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      title: json['title'] ?? '',
      description: json['desc'] ?? '',
      action: json['link_title'] ?? '',
      featured: json['featured_text'] ?? '',
      icon: json['featured_icon'] ?? '',
      image: json['background_image_url'] ?? '',
    );
  }
}
