import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class TourModel extends ListingModel {
  final String duration;

  TourModel({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required super.location,
    required super.review,
    required this.duration,
  });

  @override
  ListingEntity toEntity() {
    return TourEntity(
      id: id,
      title: title,
      image: image,
      content: content,
      isFeatured: isFeatured,
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
      isFeatured: json['is_featured'] == 1,
      location: CategoryModel.fromJson(json['location']),
      review: ReviewModel.fromJson(json['review_score']),
    );
  }
}
