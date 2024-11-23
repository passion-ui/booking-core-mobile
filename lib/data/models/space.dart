import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class SpaceModel extends ProductModel {
  final int guests;
  final int beds;
  final int bathrooms;
  final int squares;

  SpaceModel({
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
    required this.guests,
    required this.beds,
    required this.bathrooms,
    required this.squares,
  });

  @override
  ProductEntity toEntity() {
    return SpaceEntity(
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
      guests: guests,
      beds: beds,
      bathrooms: bathrooms,
      squares: squares,
    );
  }

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(
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
      guests: json['max_guests'] ?? 0,
      beds: json['bed'] ?? 0,
      bathrooms: json['bathroom'] ?? 0,
      squares: json['square'] ?? 0,
    );
  }
}
