import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class CarModel extends ListingModel {
  CarModel({
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
  });

  @override
  ListingEntity toEntity() {
    return CarEntity(
      id: id,
      title: title,
      image: image,
      content: content,
      isFeatured: isFeatured,
      price: price,
      salePrice: salePrice,
      saleOff: saleOff,
      location: location.toEntity(),
      review: review.toEntity(),
    );
  }

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      content: json['content'] ?? '',
      isFeatured: json['is_featured'] == 1,
      saleOff: json['discount_percent'] ?? '',
      price: num.tryParse('${json['price']}') ?? 0,
      salePrice: num.tryParse('${json['sale_price']}') ?? 0,
      location: CategoryModel.fromJson(json['location']),
      review: ReviewModel.fromJson(json['review_score']),
    );
  }
}
