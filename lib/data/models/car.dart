import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class CarModel extends ProductModel {
  final int passenger;
  final String gear;
  final int baggage;
  final int door;

  CarModel({
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
    required super.related,
    required this.passenger,
    required this.gear,
    required this.baggage,
    required this.door,
  });

  @override
  ProductEntity toEntity() {
    return CarEntity(
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
      related: related?.map((e) => e.toEntity()).toList(),

      ///Specific
      passenger: passenger,
      gear: gear,
      baggage: baggage,
      door: door,
    );
  }

  factory CarModel.fromJson(Map<String, dynamic> json) {
    final shared = ProductModel.shared(json);
    return CarModel(
      id: shared.id,
      type: shared.type,
      title: shared.title,
      image: shared.image,
      content: shared.content,
      isFeatured: shared.isFeatured,
      saleOff: shared.saleOff,
      price: shared.price,
      salePrice: shared.salePrice,
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
      related: shared.related,
      passenger: json['max_guest'] ?? 0,
      gear: json['gear'] ?? '',
      baggage: json['baggage'] ?? 0,
      door: json['door'] ?? 0,
    );
  }
}
