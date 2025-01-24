import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class EventModel extends ProductModel {
  final String duration;
  final String startTime;

  EventModel({
    required super.id,
    required super.type,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required super.address,
    required super.location,
    required super.review,
    required super.banner,
    required super.gallery,
    required super.video,
    required super.gps,
    required super.properties,
    required super.feedbacks,
    required super.faqs,
    required this.duration,
    required this.startTime,
  });

  @override
  ProductEntity toEntity() {
    return EventEntity(
      id: id,
      type: type,
      title: title,
      image: image,
      content: content,
      isFeatured: isFeatured,
      price: price,
      salePrice: salePrice,
      saleOff: saleOff,
      address: address,
      location: location.toEntity(),
      review: review.toEntity(),
      banner: banner,
      gallery: gallery,
      video: video,
      gps: gps?.toEntity(),
      properties: properties?.map((e) => e.toEntity()).toList(),
      feedbacks: feedbacks?.map((e) => e.toEntity()).toList(),
      faqs: faqs?.map((e) => e.toEntity()).toList(),

      ///Specific
      duration: duration,
      startTime: startTime,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final shared = ProductModel.shared(json);

    return EventModel(
      id: shared.id,
      type: shared.type,
      title: shared.title,
      image: shared.image,
      content: shared.content,
      isFeatured: shared.isFeatured,
      price: shared.price,
      salePrice: shared.salePrice,
      saleOff: shared.saleOff,
      address: shared.address,
      location: shared.location,
      review: shared.review,
      banner: shared.banner,
      gallery: shared.gallery,
      video: shared.video,
      gps: shared.gps,
      properties: shared.properties,
      feedbacks: shared.feedbacks,
      faqs: shared.faqs,
      duration: json['duration'] ?? '',
      startTime: json['start_time'] ?? '',
    );
  }
}
