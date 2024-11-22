import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BoatModel extends ListingModel {
  final int guests;
  final int cabins;
  final String length;
  final String speed;

  BoatModel({
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
    required this.cabins,
    required this.length,
    required this.speed,
  });

  @override
  ListingEntity toEntity() {
    return BoatEntity(
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
      cabins: cabins,
      length: length,
      speed: speed,
    );
  }

  factory BoatModel.fromJson(Map<String, dynamic> json) {
    return BoatModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      content: json['content'] ?? '',
      isFeatured: json['is_featured'] == 1,
      saleOff: json['discount_percent'] ?? '',
      price: num.tryParse('${json['price']}') ?? 0,
      salePrice: num.tryParse('${json['sale_price']}') ?? 0,
      location: LocationModel.fromJson(json['location']),
      review: ReviewModel.fromJson(json['review_score']),
      guests: json['max_guest'] ?? 0,
      cabins: json['cabin'] ?? 0,
      length: json['length'] ?? '',
      speed: json['speed'] ?? '',
    );
  }
}
