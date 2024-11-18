import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ListingModel {
  final int id;
  final String title;
  final String image;
  final String content;

  ListingModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
  });

  ListingEntity toEntity() {
    return ListingEntity(
      id: id,
      title: title,
      image: image,
      content: content,
    );
  }

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    switch (json['object_model']) {
      case 'hotel':
        return HotelModel.fromJson(json);

      case 'tour':
        return TourModel.fromJson(json);

      default:
        return ListingModel(
          id: json['id'] ?? 0,
          title: json['title'] ?? '',
          image: json['image'] ?? '',
          content: json['content'] ?? '',
        );
    }
  }
}
