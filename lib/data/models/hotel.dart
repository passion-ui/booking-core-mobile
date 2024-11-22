import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class HotelModel extends ListingModel {
  HotelModel({
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
    return HotelEntity(
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

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
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
