import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class HotelModel extends ListingModel {
  HotelModel({
    required super.id,
    required super.title,
    required super.price,
    required super.image,
    required super.content,
    required super.location,
    required super.review,
  });

  @override
  ListingEntity toEntity() {
    return HotelEntity(
      id: id,
      title: title,
      price: price,
      image: image,
      content: content,
      location: location.toEntity(),
      review: review.toEntity(),
    );
  }

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
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
