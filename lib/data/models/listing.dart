import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ListingModel {
  final int id;
  final String title;
  final num price;
  final String image;
  final String content;
  final LocationModel location;
  final ReviewModel review;

  ListingModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.content,
    required this.location,
    required this.review,
  });

  ListingEntity toEntity() {
    return ListingEntity(
      id: id,
      title: title,
      price: price,
      image: image,
      content: content,
      location: location.toEntity(),
      review: review.toEntity(),
    );
  }

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    switch (json['object_model']) {
      case 'hotel':
        return HotelModel.fromJson(json);
      default:
        return ListingModel(
          id: json['id'] ?? 0,
          title: json['title'] ?? '',
          price: num.tryParse(json['price'] ?? "") ?? 0,
          image: json['image'] ?? '',
          content: json['content'] ?? '',
          location: LocationModel.fromJson(json['location']),
          review: ReviewModel.fromJson(json['review_score']),
        );
    }
  }
}
