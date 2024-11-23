import 'package:booking/data/data.dart';
import 'package:booking/data/models/boat.dart';
import 'package:booking/domain/domain.dart';

class ProductModel {
  final int id;
  final String title;
  final String image;
  final String content;
  final bool isFeatured;
  final num price;
  final num salePrice;
  final String saleOff;
  final CategoryModel location;
  final ReviewModel review;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.isFeatured,
    required this.price,
    required this.salePrice,
    required this.saleOff,
    required this.location,
    required this.review,
  });

  ProductEntity toEntity() {
    return ProductEntity(
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    switch (json['object_model']) {
      case 'hotel':
        return HotelModel.fromJson(json);

      case 'tour':
        return TourModel.fromJson(json);

      case 'space':
        return SpaceModel.fromJson(json);

      case 'car':
        return CarModel.fromJson(json);

      case 'event':
        return EventModel.fromJson(json);

      case 'boat':
        return BoatModel.fromJson(json);

      default:
        return ProductModel(
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
}
