import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class CarModel extends ProductModel {
  final int passenger;
  final String gear;
  final int baggage;
  final int door;

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
    required this.passenger,
    required this.gear,
    required this.baggage,
    required this.door,
  });

  @override
  ProductEntity toEntity() {
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
      passenger: passenger,
      gear: gear,
      baggage: baggage,
      door: door,
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
      passenger: json['max_guest'] ?? 0,
      gear: json['gear'] ?? '',
      baggage: json['baggage'] ?? 0,
      door: json['door'] ?? 0,
    );
  }
}
