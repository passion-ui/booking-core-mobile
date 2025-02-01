import 'package:booking/domain/domain.dart';

class ItineraryModel {
  final String title;
  final String description;
  final String content;
  final String image;

  ItineraryModel({
    required this.title,
    required this.description,
    required this.content,
    required this.image,
  });

  ItineraryEntity toEntity() {
    return ItineraryEntity(
      title: title,
      description: description,
      content: content,
      image: image,
    );
  }

  factory ItineraryModel.fromJson(Map<String, dynamic> json) {
    return ItineraryModel(
      title: json['title'] ?? '',
      description: json['desc'] ?? '',
      content: json['content'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
