import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class EventModel extends ListingModel {
  final String duration;
  final String startTime;

  EventModel({
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
    required this.startTime,
  });

  @override
  ListingEntity toEntity() {
    return EventEntity(
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
      duration: duration,
      startTime: startTime,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
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
      duration: json['duration'] ?? '',
      startTime: json['start_time'] ?? '',
    );
  }
}
