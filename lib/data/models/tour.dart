import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class TourModel extends ListingModel {
  final num price;
  final num salePrice;
  final String saleOff;
  final String duration;
  final LocationModel location;
  final ReviewModel review;

  TourModel({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required this.price,
    required this.salePrice,
    required this.saleOff,
    required this.duration,
    required this.location,
    required this.review,
  });

  @override
  ListingEntity toEntity() {
    return TourEntity(
      id: id,
      title: title,
      image: image,
      content: content,
      price: price,
      salePrice: salePrice,
      saleOff: saleOff,
      duration: duration,
      location: location.toEntity(),
      review: review.toEntity(),
    );
  }

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      saleOff: json['discount_percent'] ?? '',
      price: num.tryParse(json['price'] ?? "") ?? 0,
      salePrice: num.tryParse(json['sale_price'] ?? "") ?? 0,
      image: json['image'] ?? '',
      content: json['content'] ?? '',
      location: LocationModel.fromJson(json['location']),
      review: ReviewModel.fromJson(json['review_score']),
    );
  }
}
